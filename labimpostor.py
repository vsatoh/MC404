# Função para imprimir a mensagem de resultado
def imprimir_resultado(resultado):
    if resultado == "Ryan Gosling":
        print("Meu Deus! Ryan Gosling! Ele é muito eu!")
    else:
        print(f"Parabéns! Sua Barbie é {resultado}")

# Mensagem de boas-vindas
print("Olá! Pronta pra descobrir qual Barbie você é?")

# Pergunta 1
print("Qual a sua atividade favorita?")
print("A) Cantar")
print("B) Dançar")
print("C) Codar")

resposta1 = input().strip().upper()

# Verifica se a resposta da pergunta 1 é válida
if resposta1 not in ["A", "B", "C"]:
    print("Essa Barbie não existe!")
else:
    # Pergunta 2 (para resposta A)
    if resposta1 == "A":
        print("Você gosta de natureza?")
        print("A) Sim")
        print("B) Não")

        resposta2a = input().strip().upper()

        # Verifica se a resposta da pergunta 2 é válida
        if resposta2a not in ["A", "B"]:
            print("Essa Barbie não existe!")
        else:
            if resposta2a == "A":
                print("Você é competitiva?")
                print("A) Sim")
                print("B) Não")

                resposta3a = input().strip().upper()

                # Verifica se a resposta da pergunta 3 é válida
                if resposta3a not in ["A", "B"]:
                    print("Essa Barbie não existe!")
                elif resposta3a == "A":
                    imprimir_resultado("Merliah - Barbie em vida de Sereia")
                else:
                    imprimir_resultado("Rosella - Barbie em princesa da ilha")
            else:
                imprimir_resultado("Liana - Barbie em o Castelo de Diamante")

    # Pergunta 2 (para resposta B)
    elif resposta1 == "B":
        print("Qual atividade você gosta mais?")
        print("A) Dirigir")
        print("B) Dançar")

        resposta2b = input().strip().upper()

        # Verifica se a resposta da pergunta 2 é válida
        if resposta2b not in ["A", "B"]:
            print("Essa Barbie não existe!")
        else:
            if resposta2b == "A":
                print("Você tem irmãos?")
                print("A) Sim")
                print("B) Não")

                resposta3b = input().strip().upper()

                # Verifica se a resposta da pergunta 3 é válida
                if resposta3b not in ["A", "B"]:
                    print("Essa Barbie não existe!")
                elif resposta3b == "B":
                    imprimir_resultado("Odette - Barbie lago dos cisnes")
                else:
                    print("Quantos irmãos você tem?")
                    num_irmaos = input().strip()

                    # Verifica se o número de irmãos é um número inteiro não negativo
                    if not num_irmaos.isdigit() or int(num_irmaos) < 0:
                        print("Essa Barbie não existe!")
                    elif int(num_irmaos) == 0:
                        imprimir_resultado("Barbie sem irmãos")
                    elif 0 < int(num_irmaos) <= 3:
                        imprimir_resultado("Tori - Barbie: a princesa e a popstar")
                    elif int(num_irmaos) == 3:
                        imprimir_resultado("Corinne - Barbie e as três mosqueteiras")
                    else:
                        imprimir_resultado("Genevieve - Barbie 12 princesas")

            else:
                imprimir_resultado("Blair - Barbie escola de princesas")

    # Pergunta 2 (para resposta C)
    elif resposta1 == "C":
        print("Qual você gosta mais?")
        print("A) Moda")
        print("B) Estudar")
        print("C) Brincar com pet")

        resposta2c = input().strip().upper()

        # Verifica se a resposta da pergunta 2 é válida
        if resposta2c not in ["A", "B", "C"]:
            print("Essa Barbie não existe!")
        elif resposta2c == "A":
            imprimir_resultado("A Barbie - Moda e Magia")
        elif resposta2c == "B":
            imprimir_resultado("Blair - Barbie escola de princesas")
        else:
            imprimir_resultado("Elina - Barbie fairytopia")