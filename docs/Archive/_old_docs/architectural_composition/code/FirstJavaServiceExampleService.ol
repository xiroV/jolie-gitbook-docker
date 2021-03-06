include "console.iol"

include "FirstJavaServiceInterface.iol"

outputPort FirstJavaServiceOutputPort {
  Interfaces: FirstJavaServiceInterface
}

embedded {
  Java:
    "org.jolie.example.FirstJavaService" in FirstJavaServiceOutputPort
}

execution{ concurrent }

inputPort MyInputPort {
  Location: "socket://localhost:9090"
  Protocol: sodep
  Interfaces: FirstJavaServiceInterface
}


main {
    HelloWorld( request )( response ) {
        println@Console("I am the embedder")();
        HelloWorld@FirstJavaServiceOutputPort( request )( response )
    }
}
