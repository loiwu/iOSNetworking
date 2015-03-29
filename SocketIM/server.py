from twisted.internet.protocol import Factory
from twisted.internet import reactor
 
factory = Factory()
reactor.listenTCP(80, factory)
reactor.run()