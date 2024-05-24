#A01784107
#Finite Automatons
#16/04/24
#Joseph Shakalo


# An automata is defined as (Q, \sigma, \Delta, F, q_0)

defmodule DFA do
  # Automata configuration:
  # {delta, accept, q0}
  # Configures and runs the DFA for a given string.
  def arithmetic(string) do
    automata = {&DFA.delta_arithmetic/2, [:int, :indot, :var, :intspace, :floatspace, :close, :exp, :varspace, :closespace], :start}
    string
    |> String.graphemes() # Convert string into a list of graphemes
    |> dfa(automata, [], []) # Passing the automata tuple correctly
  end


 # cond determina si continuar procesando o agregar un nuevo token a la lista.

  # Processes each character of the string using the DFA rules.

  # delta.(state, char) aplica la función de transición para obtener el nuevo estado y si se encontró un token.

  def dfa([char | tail], {delta, accept, state}, token, acc) do
    [newstate, found] = delta.(state, char)

    # update acumula los caracteres procesados si no son espacios.

    update = if char != " " do
      [char | acc]
    else
      acc
    end

    cond do
      found == false -> dfa(tail, {delta, accept, newstate}, token, update)
      true -> dfa(tail, {delta, accept, newstate}, [{found, Enum.reverse(tl(update)) |> Enum.join("")} | token], [hd(update)])
    end
  end

  # Esta función maneja la finalización del procesamiento cuando todos los caracteres han sido procesados.

  # Finalizes the token list when all characters have been processed.
  def dfa([], {_delta, accept, state}, token, acc) do
    cond do
      Enum.member?(accept, state) ->
        cond do
          state == :intspace ->[{:int, Enum.reverse(acc) |> Enum.join("")} | token] |> Enum.reverse()
          state == :floatspace ->[{:indot, Enum.reverse(acc) |> Enum.join("")} | token] |> Enum.reverse()
          state == :varspace ->[{:var, Enum.reverse(acc) |> Enum.join("")} | token] |> Enum.reverse()
          state == :closespace ->[{:close, Enum.reverse(acc) |> Enum.join("")} | token] |> Enum.reverse()
          true -> [{state, Enum.reverse(acc) |> Enum.join("")} | token] |> Enum.reverse()
        end
      true -> false
    end
  end

    #delta_arithmetic define las reglas de transición para cada estado basado en el carácter de entrada.

    # Defines the transition rules for each state based on the input character.
    def delta_arithmetic(start, char) do
      case start do

        # Initial satate handles the first character of the input by transitioning based on its type

        :start -> cond do
          char == " " -> [:start, false]
          is_sign(char) -> [:sign, false]
          is_digit(char) -> [:int, false]
          is_alpha(char) -> [:var, false]
          char == "(" -> [:open, false]
          true -> [:fail, false]
        end

        # int: Handles integers, on encountering spaces, dots, operators, or the exponent symbol.

        :int -> cond do
          is_digit(char) -> [:int, false]
          char == " " -> [:intspace, false]
          char == "e" || char == "E" -> [:e, false]
          is_operator(char) -> [:ope, :int]
          char == "." -> [:dot, false]
          char == ")" -> [:close, :int]
          true -> [:fail, false]
        end

        # :dot and :indot: Manages decimal points in numbers, continues with fractional digits.

        :dot -> cond do
          is_digit(char) -> [:indot, false]
          true -> [:fail, false]
        end

        :indot -> cond do
          is_digit(char) -> [:indot, false]
          char == " " -> [:floatspace, false]
          char == "e" || char == "E" -> [:e, false]
          is_operator(char) -> [:ope, :indot]
          char == ")" -> [:close, :indot]
          true -> [:fail, false]
        end

        #:ope: Processes operators, determines next state based on following characters.

        :ope -> cond do
          is_sign(char) -> [:sign, :ope]
          is_alpha(char) -> [:var, :ope]
          char == " " -> [:operator_space, false]
          char == "(" -> [:open, :ope]
          is_digit(char) -> [:int, :ope]
          true -> [:fail, false]
        end

        # :sign: Deals with signs (+/-), transitions based on subsequent characters (digits or spaces).

        :sign -> cond do
          is_digit(char) -> [:int, false]
          char == " " -> [:sign_space, false]
          true -> [:fail, false]
        end

        #:e and :exp: Manages exponent part of numbers, transitions on digits or signs.

        :e -> cond do
          is_sign(char) -> [:sign_exp, false]
          is_digit(char) -> [:exp, false]
          true -> [:fail, false]
        end

        :sign_exp -> cond do
          is_digit(char) -> [:exp, false]
          true -> [:fail, false]
        end

        :exp -> cond do
          is_digit(char) -> [:exp, false]
          is_operator(char) -> [:ope, :exp]
          true -> [:fail, false]
        end

        # :var: Processes variables, transitions for alphabets, digits, operators, or spaces.

        :var -> cond do
         is_alpha(char) -> [:var, false]
         char == " " -> [:varspace, false]
         is_operator(char) -> [:ope, :var]
         is_digit(char) -> [:var, false]
         is_sign(char) -> [:sign, :var]
         char == ")" -> [:close, :var]
         true -> [:fail, false]
        end

        #:open and :close: Manages parentheses, transitions based on nested expressions or spaces.

        :open -> cond do
          char == "(" -> [:open, :open]
          char == " " -> [:open_space, false]
          is_alpha(char) -> [:var, :open]
          is_digit(char) -> [:int, :open]
          is_sign(char) -> [:sign, :open]
          true -> [:fail, false]
        end

        :close -> cond do
          char == ")" -> [:close, :close]
          char == " " -> [:closespace, false]
          is_operator(char) -> [:ope, :close]
          is_sign(char) -> [:sign, :close]
          true -> [:fail, false]
        end

        #Space handling: Manages transitions after spaces, redirecting to relevant states for continued parsing.

        :varspace -> cond do
          char == " " -> [:varspace, false]
          is_operator(char) -> [:ope, :var]
          is_sign(char) -> [:sign, :var]
          char == ")" -> [:close, :var]
          true -> [:fail, false]
        end

        :operator_space -> cond do
          char == " " -> [:operator_space, false]
          is_sign(char) -> [:sign, :ope]
          is_digit(char) -> [:int, :ope]
          is_alpha(char) -> [:var, :ope]
          char == "(" -> [:open, :ope]
          true -> [:fail, false]
        end

        :sign_space -> cond do
          char == " " -> [:sign_space, false]
          is_digit(char) -> [:int, false]
          true -> [:fail, false]
        end

        :open_space -> cond do
          char == " " -> [:open_space, false]
          is_sign(char) -> [:sign, :open]
          is_digit(char) -> [:int, :open]
          is_alpha(char) -> [:var, :open]
          true -> [:fail, false]
        end

        :closespace -> cond do
          char == " " -> [:closespace, false]
          is_operator(char) -> [:ope, :close]
          is_sign(char) -> [:sign, :close]
          true -> [:fail, false]
        end

        :intspace -> cond do
          char == " " -> [:intspace, false]
          is_operator(char) -> [:ope, :int]
          is_sign(char) -> [:sign, :int]
          true -> [:fail, false]
        end

        :floatspace -> cond do
          char == " " -> [:floatspace, false]
          is_operator(char) -> [:ope, :indot]
          is_sign(char) -> [:sign, :indot]
          true -> [:fail, false]
        end


        :fail -> [:fail, false]
      end
    end

    #functions to check character types (digits, operators, etc.).
    def is_digit(char) do
      "0123456789"
      |> String.graphemes()
      |> Enum.member?(char)
    end

    def is_sign(char) do
      Enum.member?(["+", "-"], char)
    end

    def is_operator(char) do
      Enum.member?(["+", "-", "*", "/", "%", "^", "="], char)
    end

    def is_alpha(char) do
      lower = ?a..?z |> Enum.map(&<<&1::utf8>>)
      upper = ?A..?Z |> Enum.map(&<<&1::utf8>>)
      Enum.member?(lower ++ upper ++ ["_"], char)
    end


  end
