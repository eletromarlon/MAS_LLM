import fitz

def gera_prompt(path_to_ata: str):
    saida = ""
    """Recebe uma string com o conteúdo da ata a ser analisada e devolve o prompt completo a ser enviado para o modelo.
    
    :param pdf_path: Caminho para o arquivo PDF.
    :return: Texto extraído do PDF como uma string.
    """
    part1 = "Estou compartilhando uma ata de uma reunião da comissão gestora do açude Arneiroz II.\n\
Essas comissões têm como propósito promover a organização local, a regulamentação das atividades\n\
realizadas nos açudes e a inserção do aparato normativo de recursos hídricos na rotina de gestão dos reservatórios.\n\
Abaixo está o conteúdo da ata em formato string:"

    part2 = "Sua tarefa é atuar como engenheiro, especialista na área de Recursos Hídricos e Análise de Sentimentos,\n\
responsável por analisar os principais acontecimentos relacionados à gestão da água do açude Arneiroz II, com base nas atas.\n\
A ação a ser realizada é calcular a polaridade geral do texto, atribuindo um valor(nota) entre -1 e +1,\n\
onde -1 indica um sentimento extremamente negativo, +1 indica um sentimento extremamente positivo e 0 indica neutralidade.\n\
A resposta final deve incluir uma breve justificativa do cálculo da nota, destacando os principais pontos que influenciaram a atribuição da nota."

    # Abre o PDF
    document = fitz.open(path_to_ata)
    text = ""
    
    # Percorre todas as páginas e extrai o texto
    for page_num in range(len(document)):
        page = document[page_num]
        text += page.get_text()  # Extrai o texto da página

    document.close()  # Fecha o documento

    try:
        saida = (f"{part1}\n{text}\n{part2}")
    except Exception as e:
        print(f"No pdf {path_to_ata} foi encontrado um erro {e}")
    return saida