library(readxl)

dados <- read_excel("G:/Meu Drive/Doutorado/GRH - Aspectos Legais e Institucionais/Artigo_Tatiane_Lima_GRH/Dataset_resultados.xlsx", sheet = "Atas")


# Carregar a biblioteca ggplot2
library(ggplot2)

g<-ggplot(dados, aes(x = Volume, y = Media)) +
  geom_point() +  
  geom_smooth(method = "lm", se = FALSE, color = "gray") +  
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +  
  geom_vline(xintercept = 50, linetype = "dashed", color = "green") +  
  labs(x = "Volume (%)", y = "Notes (%)") +  
  scale_color_identity() +  
  theme_minimal() +  
  coord_fixed(ratio = 1, xlim = c(0, 100), 
              ylim = c(-100, 100))
# Salvar com dimensões específicas
ggsave("correlacao.pdf", plot = g, width = 7.5, height = 12, units = "cm")

na.omit(dados)
library(tidyr)

# Organizar os dados no formato longo
dados_long <- gather(dados, key = "Categoria", value = "Valor", 
                     Seco, Normal)

# Criar o gráfico de boxplot
# Criar o gráfico
p <- ggplot(dados_long, aes(x = Categoria, y = Valor)) +
  geom_boxplot() +  
  labs(x = "Category", y = "Notes (%)") +
  scale_x_discrete(labels = c("Seco" = "Dry", "Normal" = "Normal"))
  theme_minimal()

# Salvar com dimensões específicas
ggsave("boxplot.pdf", plot = p, width = 7.5, height = 12, units = "cm")

# Juntar gráficos 2a e 2b como painéis a e b
grafico <- g + p + plot_annotation(tag_levels = 'a')
plot (grafico)
ggsave("grafico.pdf",  width = 15, height = 12, units = "cm")

Data<-as.Date(dados$Datas)
Notas<- dados$Media
data<-dados
g<- ggplot(data, aes(x = Data, y = Notas)) +
  geom_rect(aes(xmin = min(Data), xmax = max(Data), ymin = -Inf, ymax = 0), 
            fill = "gray90", alpha = 0.5) +  # Área sombreada cinza abaixo de 0
  geom_line(color = "blue", size = 1) +   # Linha azul
  geom_point(color = "red", size = 2) +   # Pontos vermelhos
  geom_vline(xintercept = as.numeric(as.Date(c("2008-03-01", "2012-08-01", "2020-03-01"))), 
             linetype = "dashed", color = "green", size = 1) +  # Linhas verticais verdes pontilhadas
  labs(x = "Data", y = "Notes(%)") +
  scale_x_date(breaks = seq(from = as.Date("2007-01-01"), to = as.Date("2025-01-01"), by = "1 year"), 
               labels = scales::date_format("%Y")) +  # Mostrar de ano em ano
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
# Salvar com dimensões específicas
ggsave("grafico.pdf", plot = g, width = 15, height = 6, units = "cm")


