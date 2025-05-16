
# Instale os pacotes necessários, caso ainda não tenha
if (!require("pdftools")) install.packages("pdftools")
if (!require("tm")) install.packages("tm")
if (!require("wordcloud")) install.packages("wordcloud")
if (!require("RColorBrewer")) install.packages("RColorBrewer")

# Carregar bibliotecas
library(pdftools)
library(tm)
library(wordcloud)
library(RColorBrewer)

# Defina o caminho do arquivo PDF - trocar para atas do período chuvoso quando necessário
pdf_file <- "G:/Meu Drive/Doutorado/GRH - Aspectos Legais e Institucionais/Atas_CG_Arneiroz II/29_01_Atas_tratadas/Atas_Periodo_Seco.pdf"


# Extraia o texto do PDF
pdf_text <- pdf_text(pdf_file)

# Combine todas as páginas em um único texto
all_text <- paste(pdf_text, collapse = " ")

# Crie um Corpus para processamento de texto
corpus <- Corpus(VectorSource(all_text))

# Lista de palavras a serem removidas manualmente
custom_stopwords <- c("a", "à", "às", "ao", "aos", "com", "da", "das", "de", "do", "dos", 
                      "em", "no", "na", "nos", "nas", "para", "por", "sem", "sobre", 
                      "o", "os", "a", "as", "um", "uma","abaixo","arneiroz", "hm³", 
                      "cogerh", "reunião","comissão", "maria", "cassio","ata","reunião",
                    "ordinária","gestora","janeiro","fevereiro","março","abril",
                    "junho","julho","agosto","setembro","outubro","novembro","dezembro",
                    "mês","ano","município", "lauro", "sugeriu", "relatou", "mmebros", "pautas","adagri", "agir", "arnepeixe", "associação de pescadores de arneiroz", 
                    "associação de poço da vaca", "associação dos pescadores de tauá",
                    "câmara municipal de arneiroz", "câmara municipal de tauá", "cagece",
                    "cogerh", "comissão gestora do açude arneiroz ii", "comitê de bacia",
                    "comitê de bacia do alto jaguaribe", "comitê da sub-bacia hidrográfica 
                    do alto jaguaribe (csbhaj)", "comitê integrado de convivência com a seca", "funceme", 
                    "ibama", "açude","membros","barragem","taua","tauá", "ministério público", "município de tauá", "prefeitura municipal de arneiroz", 
                    "prefeitura municipal de cariús", "comitê","prefeitura municipal de iguatu", "prefeitura municipal de jucás", 
                    "prefeitura municipal de saboeiro", "saae", "secretaria da pesca do estado", "secretaria de agricultura municipal de arneiroz", 
                    "secretaria de agricultura municipal de jucás", "secretaria de pesca do estado", "semace", 
                    "sisar", "sindicato dos trabalhadores rurais de tauá", "superintendência municipal de meio ambiente de tauá",
                    "um","dois","três","alto","jaguaribe","hidrográfica","dias","apresentou","cássio","realizada"," – ",
                    "m³","rua","anatarino","disse","sendo","informou","nº","evaneide","gerente",
                    "iguatuce","wwwcogerhcombr","bairro","josé","maio","núbia","vitor","apenas","explicou","falou"
                , "francisco","isaac","perguntou","seguida","silva","vinte","ceará","solicitou","ainda","esclareceu",
                "lembrou","somente","todos","fazer","conforme","atualmente","contou","respondeu",
                "ter","seguintes","ser","horas","assim","após","milhões","arneirozce","-", "fez","onde", "pois", "constar",
                "encerrada", "faltando","mil", "redigi", "rosângela", "secretaria", "tratar", "atualmente", "continuando", "data", 
                "dia", "lembrou", "sebastião", "após", "martins", "informativa", "respondeu", "seguintes", "segundo", "solicitou",
                "teixeira", "uchõa", "araújo", "assim", "conforme", "constou", "esclareceu", "feitosa", "horas", "meses", "milhões", 
                "torres", "ano", "aprovou", "carmelita", "chegaria", "equivalente", "estando","faz", "francinilda", "francisca", 
                "hewelanya", "hewelânya", "iltemar", "iniciando", "início", "lima", "municipal", "nesse", "passando", "pereira", "poderá", "porque", "porém", 
                "realizado", "-", "-","", ".","afirmou", "algumas", "alcides", "anteriormente", "antônio", "aprovada", "aprovado", "aristeu", "assinam", "através", "borges", "cada", "cep", "cinco", "citou", "colocou", "consensual", "conseguiu", "dentro", "dez", "definida", "definidos", "definir", "deste", "deu", "devem", "discutir", "diversas", "encontra", "estar", "existem", "feliciano", "feita", "fernando", "ficou", "fim", "gianni", "gotardo", "grandes", "haver", "havendo", "lançadas", "lavrei", "levam", "localizado", "logo", "manterá", "mardônio", "média", "mesma", "nada", "neste", "nove", "número", "oito", "outro", "outras", "outros", "passou", "pode", "possuir", "prado", "propôs", "quinze", "raimundo", "realizar", "realizouse", "referido", "respectivas", "segue", "seis", "serem", "sohidra", "solicitando", "srh", "sra", "tal", "total", "trabalhada", "uchôa", "vandiza", "verificar",
                "reforçou", "totalizando","água", "jucás", "saboeiro", "sede", "saudou", "sales", "reforçou", "realizado", "", "●", "–", ""
                )
        
                     

# Pré-processamento do texto
corpus <- tm_map(corpus, content_transformer(tolower)) # Converter para minúsculas
corpus <- tm_map(corpus, removePunctuation)           # Remover pontuação
corpus <- tm_map(corpus, removeNumbers)               # Remover números
corpus <- tm_map(corpus, removeWords, stopwords("pt"))# Remover stopwords em inglês
corpus <- tm_map(corpus, removeWords, custom_stopwords) # Remover palavras personalizadas
corpus <- tm_map(corpus, stripWhitespace)             # Remover espaços em branco extras
corpus <- tm_map(corpus, content_transformer(function(x) {
  gsub("\\b\\w{1,2}\\b", "", x) # Remove palavras com 1 ou 2 letras
}))

# Crie uma matriz de termos (Term-Document Matrix)
dtm <- TermDocumentMatrix(corpus)
matrix <- as.matrix(dtm)
word_freq <- sort(rowSums(matrix), decreasing = TRUE)
word_freq_df <- data.frame(word = names(word_freq), freq = word_freq)

# Instale o pacote ggwordcloud, se necessário
if (!requireNamespace("ggwordcloud", quietly = TRUE)) {
  install.packages("ggwordcloud")
}
# Carregue o ggwordcloud
library(ggwordcloud)
library(ggplot2)

# Gere a nuvem de palavras
word_freq_filtered <- subset(word_freq_df, freq >= 5)

# Salvar o dataframe com palavras e frequências em CSV
write.csv(word_freq_filtered, "G:/Meu Drive/Doutorado/GRH - Aspectos Legais e Institucionais/word_freq_seco.csv", row.names = FALSE)

cat("Arquivo CSV salvo com as palavras para tradução manual.")

# Carregar o CSV com as palavras já traduzidas
word_freq_translated <- read.csv("G:/Meu Drive/Doutorado/GRH - Aspectos Legais e Institucionais/word_freq_seco.csv")


wordcloud_plot <- ggplot(word_freq_translated, aes(label = translation, size = freq, color=freq)) +
  geom_text_wordcloud_area() +
  scale_color_gradient(low = "darkblue", high = "red") + # Ajusta as cores das palavras
  scale_size_area(max_size = 50) + # Define o tamanho máximo das palavras
  theme_minimal() + 
  theme(
    panel.background = element_rect(fill = "white", color = NA), # Fundo branco
    plot.background = element_rect(fill = "white", color = NA)   # Fundo do gráfico branco
  )


# Salve a nuvem de palavras como arquivo de imagem
output_path <- "G:/Meu Drive/Doutorado/GRH - Aspectos Legais e Institucionais/Nuvem_seco.png" # Substitua pelo caminho desejado
ggsave(output_path, plot = wordcloud_plot, width = 16, height = 12, dpi = 500)

cat("Nuvem de palavras salva em:", output_path)
