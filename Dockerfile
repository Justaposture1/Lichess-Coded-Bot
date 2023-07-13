FROM ubuntu:jammy
COPY . .

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget unzip python3 python3-pip git python3-pip p7zip
RUN mv config.yml.default config.yml
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN wget https://zipproth.de/Brainfish/Cerebellum_Light_3Merge_200916.7z -O Cerebellum.7z
RUN 7zr e Cerebellum.7z && rm Cerebellum.7z

#add variant books 
RUN bash makefish.sh

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x stockfish_x64_modern
\
# Engine name is here ^^^^^^

CMD python3 run.py
