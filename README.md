
# MAS_LLM: Minutes Analysis System with LLM

MAS_LLM (Minutes Analysis System with LLM) is a comprehensive and hybrid analytical pipeline developed in R and Python for conducting in-depth textual, graphical, and statistical analysis of meeting minutes, especially for water governance and legal-institutional management studies.

This system leverages both traditional statistical techniques and modern Large Language Model (LLM) capabilities to extract, quantify, visualize, and interpret institutional behavior, sentiment polarity, and thematic trends in textual meeting records.

## Features

### 📊 Statistical and Graphical Analysis (R)

- **Scatter Plot Analysis**: Relates sentiment average ("Media") with water volume (%) to assess potential correlation.
- **Boxplots**: Visualizes sentiment distribution under different hydrological regimes (e.g., Dry vs. Normal periods).
- **Time Series Plot**: Shows sentiment evolution over time, with key institutional turning points (2008, 2012, 2020) highlighted.
- **Panel Arrangement**: Composes multiple graphs (scatter and boxplots) into cohesive analytical panels.

### ☁️ Word Cloud Generation (R)

- **PDF Processing**: Converts meeting minute PDFs into analyzable plain text.
- **Custom Stopword Filtering**: Applies an extensive domain-specific stopword list for cleaning texts.
- **Word Frequency Computation**: Builds a Term-Document Matrix and computes word frequencies.
- **Export to CSV**: Saves frequent words for manual translation and further use.
- **Word Cloud Visualization**: Generates and exports high-resolution word clouds with translated keywords.

### 🤖 Sentiment Analysis with LLMs (Python)

- **LLM API Integration**: Interfaces with a locally hosted LLM (e.g., via Ollama) to analyze sentiment from meeting texts.
- **Prompt Engineering**: Sends each cleaned excerpt for multiple sentiment inference iterations (e.g., 30x) to compute average polarity for robust sentiment estimation.
- **Batch Logging**: Results are logged systematically for reproducibility and further statistical analysis.

### 🗃️ Data Management

- **R Integration with Excel**: Uses `readxl` for structured dataset reading (.xlsx).
- **Python Logging**: JSON and CSV logs for traceability of the LLM evaluations.
- **File Output**: All plots and analyses are saved in standardized sizes and high resolution for use in academic publishing.

## Installation

### R Environment

Make sure the following R packages are installed:

```r
install.packages(c("readxl", "ggplot2", "tm", "wordcloud", "RColorBrewer", "ggwordcloud", "tidyr"))
```

### Python Environment

The Python part depends on:

- `openai` or compatible LLM client
- `pandas`, `json`, `time`, `requests`, `matplotlib`, `seaborn`

Install them using:

```bash
pip install pandas matplotlib seaborn requests
```

## Folder Structure

```
MAS_LLM/
│
├── R/
│   ├── graphs_analysis.R       # Scatter, boxplot, time-series plots
│   ├── wordcloud_generator.R   # Word cloud extraction and cleaning
│
├── Python/
│   ├── llm_sentiment_analysis.py   # Text cleaning, prompt generation, LLM API integration
│
├── data/
│   ├── Dataset_resultados.xlsx     # Input data for statistical plots
│   ├── Atas_Periodo_Seco.pdf       # Raw PDF of meeting minutes
│   ├── word_freq_seco.csv          # Translated word frequencies for word cloud
│
├── output/
│   ├── correlacao.pdf
│   ├── boxplot.pdf
│   ├── grafico.pdf
│   ├── Nuvem_seco.png
│
└── README.md
```

## Innovation and Academic Relevance

MAS_LLM innovatively blends quantitative and qualitative analyses through:

- Hybrid architecture: Merging NLP (LLM-based) with classic statistical inference.
- Rich visual outputs: Tailored to hydrological and governance contexts.
- Custom stopword engineering: Designed specifically for institutional Portuguese meeting records.
- Robustness: Repeated inference per text using LLMs for higher sentiment reliability.

This system is especially suited for researchers, public policy analysts, and governance scholars studying stakeholder behavior over time in water resource management contexts.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
