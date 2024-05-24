#Evidencia Joseph Shakalo
#Matrícula: A01784107
#Fecha: 24/05/2024

defmodule Lexer do
  # Main function to read and convert files
  def read_and_convert(in_filename) do
    # Derive the output filename from the input filename
    out_filename = Path.rootname(in_filename) <> ".html"

    # Open the output file with UTF-8 encoding
    {:ok, out_fd} = File.open(out_filename, [:write, :utf8])

    # HTML header template
    html_header = """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Code Highlight</title>
      <link rel="stylesheet" href="styles.css">
    </head>
    <body>
    <h1>Python code to HTML using tokens</h1>
    <pre>
    """

    # HTML footer template
    html_footer = """
    </pre>
    </body>
    </html>
    """

    # Process each line of the input file, tokenize, classify, and convert to HTML
    in_filename
    |> File.stream!([], :line)  # Stream the file line by line
    |> Enum.map(&process_line/1)  # Process each line
    |> Enum.join()  # Join all processed lines
    |> then(&IO.binwrite(out_fd, html_header <> &1 <> html_footer))  # Write the HTML content to the file

    File.close(out_fd)  # Close the output file
  end

  # Function to process a complete line
  defp process_line(line) do
    # Split the line into two parts: code and comment
    case String.split(line, "#", parts: 2) do
      [code, comment] ->  # If there's a comment
        process_code(code) <> to_html({:comment, "#" <> comment})  # Process the code and the comment
      [code] ->  # If there's no comment
        process_code(code)  # Just process the code
    end
  end

  # Function to process the code part of the line
  defp process_code(code) do
    code
    |> String.split(~r/(\s+|[^a-zA-Z0-9])/, include_captures: true)  # Split the code into tokens
    |> Enum.map(&classify/1)  # Classify each token
    |> Enum.map(&to_html/1)  # Convert each classified token to HTML
    |> Enum.join("")  # Join all HTML tokens
  end

  # Function to classify tokens based on their content
  defp classify(token) do
    cond do
      token in keywords() -> {:keyword, token}  # If the token is a keyword
      Regex.match?(operators(), token) -> {:operator, token}  # If the token is an operator
      Regex.match?(delimiters(), token) -> {:delimiter, token}  # If the token is a delimiter
      Regex.match?(literal(), token) -> {:literal, token}  # If the token is a literal
      Regex.match?(identifier(), token) -> {:identifier, token}  # If the token is an identifier
      Regex.match?(whitespace(), token) -> {:whitespace, token}  # If the token is whitespace
      true -> {:unknown, token}  # If the token doesn't match any category
    end
  end

  # Function to convert a classified token to HTML using a suitable CSS class
  defp to_html({type, value}) do
    class = case type do
      :keyword -> "keyword"
      :operator -> "operator"
      :comment -> "comment"
      :delimiter -> "delimiter"
      :identifier -> "identifier"
      :literal -> "literal"
      :whitespace -> "whitespace"
      _ -> "unknown"
    end

    if type == :whitespace do
      value  # Return the whitespace value as-is
    else
      "<span class=\"#{class}\">#{value}</span>"  # Wrap the value in a span with the appropriate class
    end
  end

  # Private functions that return patterns and keywords
  # Comments pattern
  defp comment do
    ~r/#.*/
  end

  # Keywords list
  defp keywords do
    ~w(print and as assert async await break class continue def del elif else except finally for from global if import in ^is\b lambda nonlocal ^not\b or pass raise return try while with yield)
  end

  # Operators pattern
  defp operators do
    ~r/(\+|-|\*|\/|==|!=|>|<|>=|<=|=|\+=|-=|\*=|\/=|%|\*\*|\/\/)/
  end

  # Delimiters pattern
  defp delimiters do
    ~r/(\(|\)|\[|\]|\{|\}|:|,|\.|\"|\')/
  end

  # Identifiers pattern
  defp identifier do
    ~r/[a-zA-Z_][0-9_]*/
  end

  # Literals pattern
  defp literal do
    ~r/(\d+(\.\d+)?|True|False|None)/
  end

  # Whitespace pattern
  defp whitespace do
    ~r/\s+/
  end

end

# Example usage:
Lexer.read_and_convert("python_code.py")

# To run code on the terminal type: elixir lexer.exs
