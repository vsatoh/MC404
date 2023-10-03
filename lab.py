print("Olá! Pronta pra descobrir qual barbie você é?")

atividade_favorita = input("Qual a sua atividade favorita? A) Cantar B) Dançar C) Codar: ").upper()

if atividade_favorita not in ['A', 'B', 'C']:
    print("Essa Barbie não existe!")
else:
    if atividade_favorita == 'A':
        gosta_natureza = input("Você gosta de natureza? A) Sim B) Não: ").upper()
        
        if gosta_natureza == 'A':
            eh_competitiva = input("Você é competitiva? A) Sim B) Não: ").upper()
            if eh_competitiva == 'A':
                print("Parabéns! Sua Barbie é Merliah - Barbie em vida de Sereia")
            elif eh_competitiva == 'B':
                print("Parabéns! Sua Barbie é Rosella - Barbie em princesa da ilha")
            else:
                print("Essa Barbie não existe!")
        
        elif gosta_natureza == 'B':
            print("Parabéns! Sua Barbie é Liana - Barbie em o Castelo de Diamante")
        else:
            print("Essa Barbie não existe!")

    elif atividade_favorita == 'B':
        atividade_preferida = input("Qual atividade você gosta mais? A) Dirigir B) Dançar: ").upper()
        
        if atividade_preferida == 'A':
            print("OMG he’s literally me, Ryan Gosling")
        elif atividade_preferida == 'B':
            tem_irmaos = input("Você tem irmãos? A) Sim B) Não: ").upper()
            
            if tem_irmaos == 'A':
                num_irmaos = input("Quantos irmãos você tem? ")
                
                if num_irmaos.isdigit():
                    num_irmaos = int(num_irmaos)
                    if num_irmaos == 0:
                        print("Barbie sem irmãos")
                    elif num_irmaos <= 3:
                        print("Parabéns! Sua Barbie é Tori - Barbie: a princesa e a popstar")
                    elif num_irmaos == 3:
                        print("Parabéns! Sua Barbie é Corinne - Barbie e as três mosqueteiras")
                    else:
                        print("Parabéns! Sua Barbie é Genevieve - Barbie 12 princesas")
                else:
                    print("Essa Barbie não existe!")
            
            elif tem_irmaos == 'B':
                print("Parabéns! Sua Barbie é Odette - Barbie lago dos cisnes")
            else:
                print("Essa Barbie não existe!")
        
        else:
            print("Essa Barbie não existe!")

    else:
        gosta_mais = input("Qual você gosta mais? A) Moda B) Estudar C) Brincar com pet: ").upper()
        
        if gosta_mais == 'A':
            print("Parabéns! Sua Barbie é A Barbie - Moda e Magia")
        elif gosta_mais == 'B':
            print("Parabéns! Sua Barbie é Blair - Barbie escola de princesas")
        elif gosta_mais == 'C':
            print("Parabéns! Sua Barbie é Elina - Barbie fairytopia")
        else:
            print("Essa Barbie não existe!")