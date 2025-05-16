import requests
import json, os
from prompt_generator import gera_prompt

model = "llama3.2"

## Para rodar este código é necessário:
## Instalar o Gerenciado de conteiners para modelos de IA Ollama
## WINDOWS -> https://ollama.com/download/OllamaSetup.exe
## Linux -> curl -fsSL https://ollama.com/install.sh | sh
## Mac -> https://ollama.com/download/Ollama-darwin.zip
## Escolha um dos modelos disponíveis. Neste código foi utilizado o Gemma2.
## Acesse o ollama via localhost com a porta, geralmente, em 11434.

def send_2_model(prompt2, pdf_path, rodada):
    # Dados que serão enviados via POST (formato JSON)
    data = {
        "model": model,
        "prompt": prompt2
    }

    # Fazendo a requisição POST
    response = requests.post(url, json=data)

    # Verifica se a requisição foi bem-sucedida
    if response.status_code == 200:
        # Transformando a resposta em uma lista de JSONs (em string)
        json_data = response.text.splitlines()  # Cada linha é um JSON
        
        responses = []
        done = False

        # Itera sobre cada JSON da resposta
        for json_line in json_data:
            obj = json.loads(json_line)  # Converte o texto para um objeto JSON
            responses.append(obj['response'])  # Coleta o valor do campo 'response'
            if obj.get('done'):  # Verifica se 'done' é True
                done = True
                break  # Para a execução caso tenha atingido o 'done'

        # Unindo as respostas em uma frase
        full_response = ''.join(responses)
        
        with open(f'out_{rodada}_{model}_{pdf_path}.txt', 'w') as file:
            file.write(full_response)

        print("Resposta completa:", full_response)
        if done:
            print("Processamento concluído.")
        else:
            print("Processamento ainda não finalizado.")
    else:
        print("Erro na requisição. Status code:", response.status_code)


# URL da API que você deseja fazer a requisição
url = 'http://localhost:11434/api/generate'

for pdf in os.listdir("3-ultimas"):
    for i in range(30):
        prompt2 = gera_prompt("3-ultimas/" + pdf)
        send_2_model(prompt2, pdf, i)

