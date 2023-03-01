package ch.frankel.blog.grpc.server

import ch.frankel.blog.grpc.model.HelloResponse
import ch.frankel.blog.grpc.model.HelloRequest
import ch.frankel.blog.grpc.model.HelloServiceGrpc.HelloServiceImplBase
import io.grpc.stub.StreamObserver
import net.devh.boot.grpc.server.service.GrpcService

@GrpcService
class HelloService : HelloServiceImplBase() {
    override fun sayHello(request: HelloRequest, observer: StreamObserver<HelloResponse>) {
        with(observer) {
            val reply = HelloResponse.newBuilder()
                .setMessage("Hello ${request.name}")
                .build()
            onNext(reply)
            onCompleted()
        }
    }
}