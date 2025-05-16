import os
import sys

class TerminalLogger:
    def __init__(self, file_name: str):
        """
        Inicializa o logger que captura a saída do terminal.

        :param file_name: Caminho do arquivo para salvar a saída.
        """
        self.file_name = file_name
        self.console = sys.stdout  # Armazena o terminal original
        self.error_console = sys.stderr  # Armazena os erros originais
        self.log_file = open(self.file_name, "w", encoding="utf-8")

    def start(self):
        """
        Redireciona a saída padrão e de erro para o arquivo e terminal.
        """
        sys.stdout = self
        sys.stderr = self

    def stop(self):
        """
        Restaura a saída padrão e de erro ao terminal original e fecha o arquivo.
        """
        sys.stdout = self.console
        sys.stderr = self.error_console
        self.log_file.close()

    def write(self, message: str):
        """
        Escreve a mensagem no arquivo e no terminal original.

        :param message: Mensagem a ser escrita.
        """
        self.console.write(message)
        self.log_file.write(message)

    def flush(self):
        """
        Garante que a saída seja gravada imediatamente.
        """
        self.console.flush()
        self.log_file.flush()


# Exemplo de uso
if __name__ == "__main__":
    logger = TerminalLogger("Analise_27_atas_(restante).txt")
    logger.start()
    
    os.system("python send_prompt_2_server.py")
    
    logger.stop()
    print("Essa mensagem será exibida apenas no terminal após parar o logger.")
