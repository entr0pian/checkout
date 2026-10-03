FROM golang:1.27 AS build
WORKDIR /src
COPY go.mod go.sum* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /out/checkout ./cmd/server

FROM gcr.io/distroless/static-debian12
COPY --from=build /out/checkout /checkout
EXPOSE 8080
ENTRYPOINT ["/checkout"]
