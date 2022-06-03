FROM debian:stable

# Install dependencies
RUN apt-get update && \
      apt-get -y dist-upgrade && \
      apt-get install -y \
          imagemagick \
          inkscape \
          make \
          texlive-full
RUN apt-get install -y \
      inotify-tools \
      xzdec

# Add external fonts
# https://tex.stackexchange.com/questions/27659/how-to-use-downloaded-fonts-with-xetex-on-ubuntu
RUN mkdir -p /usr/local/share/fonts/truetype/noto
RUN mkdir -p /usr/local/share/fonts/opentype/noto/
RUN wget -q https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansCJK-VF.ttf.ttc -P /usr/local/share/fonts/truetype/noto
RUN wget -q https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansMonoCJK-VF.ttf.ttc -P /usr/local/share/fonts/truetype/noto
RUN wget -q https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansCJK-VF.otf.ttc -P /usr/local/share/fonts/opentype/noto/
RUN wget -q https://github.com/googlefonts/noto-cjk/raw/main/Sans/Variable/OTC/NotoSansMonoCJK-VF.otf.ttc -P /usr/local/share/fonts/opentype/noto/
RUN chown -R 1000:1000 /usr/local/share/fonts/
RUN fc-cache -f -v
RUN tlmgr init-usertree

COPY add_user add_user
RUN ./add_user
USER texuser

