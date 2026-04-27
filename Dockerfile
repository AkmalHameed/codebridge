FROM hexpm/elixir:1.18.3-erlang-27.3.1-debian-bookworm-20250317-slim

RUN apt-get update -y && apt-get install -y build-essential git curl \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

COPY assets assets
COPY config config
COPY lib lib
COPY priv priv

RUN mix assets.deploy
RUN mix compile
RUN mix release

EXPOSE 10000

CMD /app/_build/prod/rel/codebridge/bin/codebridge eval "Codebridge.Release.migrate()" && /app/_build/prod/rel/codebridge/bin/codebridge start