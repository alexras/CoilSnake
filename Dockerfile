FROM python:3.7.1-slim-stretch

# Install dependencies

RUN apt-get update && apt-get install -y g++ git libyaml-dev python3-tk python3-pil.imagetk libjpeg-dev zlib1g-dev tk8.6-dev tcl8.6-dev
RUN mkdir -p /usr/share/man/man1mkdir -p /usr/share/man/man1
RUN apt-get install -y openjdk-8-jre-headless higan

COPY . /coilsnake
WORKDIR /coilsnake
RUN make && make install

# Disable an accessibility setting that prevents tool windows from spawning
RUN sed -ibak "s/assistive_technologies=org.GNOME.Accessibility.AtkWrapper/#assistive_technologies=org.GNOME.Accessibility.AtkWrapper/g" /etc/java-8-openjdk/accessibility.properties

ENTRYPOINT /coilsnake/script/gui.py
