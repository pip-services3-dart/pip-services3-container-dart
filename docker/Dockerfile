# Start with the Dart image
FROM google/dart

# Set a working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Install all dependencies
RUN pub get
RUN pub get --offline

# Set the required environment variables
ENV USER=TestUserDocker
ENV USER2=User#2
#ENV THIRD_CONTROLLER=true
ENV THIRD_CONTROLLER=8800


# Specify the command for running the service
CMD []
ENTRYPOINT ["/usr/bin/dart", "./bin/run.dart"]