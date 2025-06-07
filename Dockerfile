# Use latest stable channel SDK.
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY container_src/. .
RUN dart pub get
RUN dart compile exe bin/server.dart -o bin/server

FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]