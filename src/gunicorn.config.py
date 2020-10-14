from signalfx_tracing import create_tracer, auto_instrument


def post_fork(server, worker):
    auto_instrument(create_tracer())

