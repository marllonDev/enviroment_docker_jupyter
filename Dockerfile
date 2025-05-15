FROM python:3.10-bullseye

# Atualiza os repositórios e instala o Java (OpenJDK 11)
RUN apt-get update && \
    apt-get install -y openjdk-11-jre && \
    rm -rf /var/lib/apt/lists/*

# Define JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Cria e ativa o ambiente virtual
ENV VIRTUAL_ENV=/opt/venv
RUN python -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copia os arquivos de requirements
COPY requirements.txt .

# Instala as dependências Python dentro da venv
RUN pip install --upgrade pip && pip install -r requirements.txt

# Define o diretório de trabalho
WORKDIR /app

# Copia o código da aplicação
COPY . .

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--NotebookApp.token=''"]