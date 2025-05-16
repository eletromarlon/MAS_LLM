import fitz  # PyMuPDF

def calcular_similaridade(linha, trecho):
    """
    Calcula a similaridade percentual entre uma linha e um trecho baseado no índice de Jaccard.
    
    Args:
        linha (str): Texto da linha.
        trecho (str): Trecho a ser comparado.
    
    Returns:
        float: Similaridade percentual entre 0 e 1.
    """
    palavras_linha = set(linha.lower().split())
    palavras_trecho = set(trecho.lower().split())
    
    # Cálculo do índice de Jaccard
    intersecao = palavras_linha.intersection(palavras_trecho)
    uniao = palavras_linha.union(palavras_trecho)
    
    return len(intersecao) / len(uniao)

def extrair_texto_sem_linhas_semelhantes(pdf_path, trechos_para_excluir, limite_similaridade=0.8):
    """
    Extrai o texto de um PDF e remove linhas semelhantes a trechos especificados, baseado em similaridade percentual.
    
    Args:
        pdf_path (str): Caminho para o arquivo PDF.
        trechos_para_excluir (list): Lista de trechos a serem comparados.
        limite_similaridade (float): Percentual mínimo de similaridade para remover uma linha (0 a 1).
        
    Returns:
        str: Texto do PDF sem as linhas semelhantes aos trechos.
    """
    # Abrir o PDF
    documento = fitz.open(pdf_path)
    texto_final = []
    
    for pagina in documento:
        # Extrair o texto da página
        texto_pagina = pagina.get_text()
        
        # Dividir o texto por linhas
        linhas = texto_pagina.splitlines()
        
        # Filtrar as linhas que NÃO são semelhantes aos trechos
        linhas_filtradas = []
        for linha in linhas:
            remover_linha = False
            for trecho in trechos_para_excluir:
                similaridade = calcular_similaridade(linha, trecho)
                if similaridade >= limite_similaridade:
                    remover_linha = True
                    break  # Evitar comparações desnecessárias
            if not remover_linha:
                linhas_filtradas.append(linha)
        
        # Reunir as linhas filtradas
        texto_limpo = "\n".join(linhas_filtradas).strip()
        texto_final.append(texto_limpo)
    
    documento.close()
    # Juntar todas as páginas em uma única string
    return "\n".join(texto_final)

# Exemplo de uso
if __name__ == "__main__":
    caminho_pdf = "37-22.02.24_Ata da 20ª Reunião Ordinária da Comissão Gestora do Açude Arneiroz II.pdf"
    
    # Trechos que serão usados para comparar as linhas
    trechos = [
        "GOVERNO DO ESTADO DO CEARÁ",
        "SECRETARIA DE RECURSOS HÍDRICOS",
        "COMPANHIA DE GESTÃO DE RECURSOS HÍDRICOS",
        "GERÊNCIA REGIONAL DA SUB-BACIA HIDROGRÁFICA DO ALTO JAGUARIBE."
        "COGERH – Gerência Regional da Sub-Bacia Hidrográfica do Alto Jaguaribe",
        "Rua Treze de maio, nº 1063, bairro São Sebastião, Iguatu-CE (85) 3195-0848/0840 (88) 3581-0800 www.cogerh.com.br",
        "COGERH – Gerência Regional da Sub-Bacia Hidrográfica do Alto Jaguaribe",
        "1", "2", "3", "4", "5", "6", "7" ] # Se quiser remover o número das linhas. No entando, acho desnecessário pois o modelo ignora numeros soltos
    
    # Extrair o texto sem as linhas que ultrapassem 80% de similaridade
    texto_resultante = extrair_texto_sem_linhas_semelhantes(caminho_pdf, trechos, limite_similaridade=0.8)
    print(texto_resultante)
