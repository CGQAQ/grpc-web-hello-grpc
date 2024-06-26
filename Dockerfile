FROM envoyproxy/envoy:v1.29-latest

# Copy the envoy configuration file
COPY envoy-config-for-docker-desktop.yaml /etc/envoy/envoy.yaml

# Expose the port
EXPOSE 6669

# Run the envoy proxy
ENTRYPOINT [ "/usr/local/bin/envoy" ]
CMD [ "-c /etc/envoy/envoy.yaml", "-l trace" ]