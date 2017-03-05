FROM bioboxes/biobox-minimal-base

MAINTAINER David Koslicki version: 0.1

ADD image /usr/local 

RUN /usr/local/install.sh

ENV SCHEMA /usr/local/schema.yaml

ENV BIOBOX_EXEC execute_biobox.sh

ENV TASKFILE /usr/local/Taskfile
