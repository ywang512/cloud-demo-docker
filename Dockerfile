FROM python:3.7.3-stretch

# Working Directory
WORKDIR /app

# Copy source code to working directory
COPY . /app/

# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN make install
# RUN pip install --upgrade pip
# RUN pip install --trusted-host pypi.python.org -r requirements.txt
