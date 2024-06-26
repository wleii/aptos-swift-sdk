import Foundation
import Types
import Clients
import OpenAPIRuntime


public struct Transaction: TransactionAPIProtocol, Sendable {
    let config: AptosConfig
    public let client: any ClientInterface
    public let build: Build
    public let sign: Sign
    public let submit: Submit

    init(config: AptosConfig) {
        self.config = config
        let middleware = ClientConfigMiddleware(
            network: config.network,
            clientConfig: config.clientConfig,
            fullnodeConfig: config.fullnodeConfig,
            indexerConfig: config.indexerConfig,
            faucetConfig: config.faucetConfig
        )
        
        guard let serverURL = URL(string: config.network.api) else {
            fatalError("Failed to create an URL with the string '\(config.network.api)'.")
        }
        
        self.client = Client(
            serverURL: serverURL,
            configuration: Configuration(),
            transport: config.transport,
            middlewares: [middleware]
        )
        self.build = .init(aptosConfig: config, client: client)
        self.sign = .init(aptosConfig: config, client: client)
        self.submit = .init(aptosConfig: config, client: client)
    }
}