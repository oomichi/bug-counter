FROM ubuntu:16.04

COPY make_graph.py /make_graph.py
COPY result.csv /result.csv

RUN apt-get update && apt-get install -y \
    python \
    python-dateutil \
    python-matplotlib \
    python-pandas

ENTRYPOINT [/make_graph.py]
