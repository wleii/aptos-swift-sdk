@_spi(Generated) import OpenAPIRuntime
import Foundation
import BCS
import BigInt

public struct LedgerVersionArg {
    public var ledgerVersion: AnyNumber?

    public init(ledgerVersion: AnyNumber? = nil) {
        self.ledgerVersion = ledgerVersion
    }
}

public enum ScriptTransactionArgumentVariants: UInt32 {
    case U8 = 0
    case U64 = 1
    case U128 = 2
    case Address = 3
    case U8Vector = 4
    case Bool = 5
    case U16 = 6
    case U32 = 7
    case U256 = 8
}

public enum TransactionPayloadVariants: UInt32 {
    case script = 0
    case entryFunction = 2
    case multiSig = 3
}

public enum TypeTagVariants: UInt32 {
    case Bool = 0
    case U8 = 1
    case U64 = 2
    case U128 = 3
    case Address = 4
    case Signer = 5
    case Vector = 6
    case Struct = 7
    case U16 = 8
    case U32 = 9
    case U256 = 10
    case Reference = 254
    case Generic = 255
}

public enum TransactionVariants: UInt32 {
  case multiAgent = 0
  case feePayer = 1
}


public protocol AnyNumber: Encodable, Sendable {}
extension Int: AnyNumber {}
extension UInt: AnyNumber {}
extension UInt8: AnyNumber {}
extension UInt16: AnyNumber {}
extension UInt32: AnyNumber {}
extension UInt64: AnyNumber {}
extension BigUInt: @unchecked Sendable, AnyNumber {}
extension BigInt: @unchecked Sendable, AnyNumber {}

// MARK: - Account & Transaction

public struct AccountData: Codable, Hashable, Sendable {
    
    public var sequenceNumber: String
    public var authenticationKey: String
    
    public enum CodingKeys: String, CodingKey {
        case sequenceNumber = "sequence_number"
        case authenticationKey = "authentication_key"
    }
}



public struct WaitForTransactionOptions: Sendable {
    public static let DEFAULT_TXN_TIMEOUT_SEC = 20
    
    public let timeoutSecs: Int?
    public let checkSuccess: Bool?
    public let waitForIndexer: Bool?
}


public typealias MoveStructValue = OpenAPIRuntime.OpenAPIObjectContainer
public typealias MoveStructId = String
public typealias MoveFunctionId = MoveStructId
public typealias EntryFunctionId = String
public typealias HexEncodedBytes = String
public typealias IdentifierWrapper = String
public typealias MoveModuleId = String


public typealias MoveUInt8Type = UInt8
public typealias MoveUInt16Type = UInt16
public typealias MoveUInt32Type = UInt32
public typealias MoveUInt64Type = UInt64
public typealias MoveUInt128Type = String
public typealias MoveUInt256Type = String
public typealias MoveAddressType = String
public typealias MoveObjectType = String
public typealias MoveOptionType<T: MoveType> = Optional<T>

public protocol MoveType:  Sendable {}
extension Int: MoveType {}
extension MoveUInt8Type: MoveType {}
extension MoveUInt16Type: MoveType {}
extension MoveUInt32Type: MoveType {}
extension MoveUInt64Type: MoveType {}
extension MoveUInt128Type: MoveType {}
// equivalence String: MoveType {}
// extension MoveUInt256Type: MoveType {}
// extension MoveAddressType: MoveType {}
// extension MoveObjectType: MoveType {}
extension Array: MoveType where Element == MoveType {}
extension Dictionary: MoveType where Key == String, Value == MoveType {}

public protocol MoveValue: Sendable {}
extension Int: MoveValue {}
extension Bool: MoveValue {}
extension String: MoveValue {}
extension MoveUInt8Type: MoveValue {}
extension MoveUInt16Type: MoveValue {}
extension MoveUInt32Type: MoveValue {}
extension MoveUInt64Type: MoveValue {}
// equivalence String: MoveType {}
// extension MoveUInt128Type: MoveValue {}
// extension MoveUInt256Type: MoveValue {}
// extension MoveAddressType: MoveValue {}
// extension MoveObjectType: MoveValue {}
// extension MoveStructId: MoveValue {}
extension MoveOptionType: MoveValue {}
extension Array: MoveValue where Element == MoveValue {}
extension Dictionary: MoveValue where Key == String, Value == MoveValue {}

public func convertToMoveValue(_ value: Any) -> MoveValue? {
    switch value {
        case let value as MoveValue:
            return value
        case let value as Dictionary<String, Any>:
            return value.compactMapValues(convertToMoveValue(_:))
        case let value as Array<Any>:
            return value.compactMap(convertToMoveValue(_:))
        default:
            return nil
    }
}
public struct MoveResource: Codable, Hashable, Sendable {
    public var type: MoveStructId
    public var data: MoveStructValue
    
    public enum CodingKeys: String, CodingKey {
        case type = "type"
        case data
    }
}

public struct MoveResourceParser<Data: Codable & Sendable>: Codable, Sendable {
    public var type: MoveStructId
    public var data: Data
    
    public enum CodingKeys: String, CodingKey {
        case type = "type"
        case data
    }
}


public struct MoveModuleBytecode: Codable, Hashable, Sendable {
    public var bytecode: String
    public var abi: MoveModule?
    
    public enum CodingKeys: String, CodingKey {
        case bytecode
        case abi
    }
}

public struct MoveModule: Codable, Hashable, Sendable {
    public var address: String
    
    public var name: String
    
    public var friends: [MoveModuleId]
    
    public var exposedFunctions: [MoveFunction]
    
    public var structs: [MoveStruct]
    
    public enum CodingKeys: String, CodingKey {
        case address
        case name
        case friends
        case exposedFunctions = "exposed_functions"
        case structs
    }
}

public struct MoveFunction: Codable, Hashable, Sendable {
    
    public var name: String
    
    public var visibility: MoveFunctionVisibility
    public var isEntry: Bool
    
    public var isView: Bool
    
    public var genericTypeParams: [MoveFunctionGenericTypeParam]
    public var params: [String]
    
    public var `return`: [String]
    
    public enum CodingKeys: String, CodingKey {
        case name
        case visibility
        case isEntry = "is_entry"
        case isView  = "is_view"
        case genericTypeParams = "generic_type_params"
        case params
        case `return` = "return"
    }
}

public enum MoveFunctionVisibility: String, Codable, Hashable, Sendable {
    case `private` = "private"
    case `public` = "public"
    case friend = "friend"
}

public enum MoveAbility: String, Codable, Hashable, Sendable {
    case store
    case drop
    case key
    case copy
}

public struct MoveFunctionGenericTypeParam: Codable, Hashable, Sendable {
    public var constraints: [MoveAbility]
    
    public enum CodingKeys: String, CodingKey {
        case constraints
    }
}

public struct MoveStructGenericTypeParam: Codable, Hashable, Sendable {
    
    public var constraints: [MoveAbility]
    
    public enum CodingKeys: String, CodingKey {
        case constraints
    }
}

public struct MoveStructField: Codable, Hashable, Sendable {
    
    public var name: String
    public var `type`: String
    
    public enum CodingKeys: String, CodingKey {
        case name
        case type = "type"
    }
}


public enum TransactionResponse: Codable, Equatable, Sendable {
    
    case blockMetadataTransaction(BlockMetadataTransaction)
    
    case genesisTransaction(GenesisTransaction)
    
    case pendingTransaction(PendingTransaction)
    
    case stateCheckpointTransaction(StateCheckpointTransaction)
    
    case userTransaction(UserTransaction)
    
    case validatorTransaction(ValidatorTransaction)

    case blockEpilogueTransaction(BlockEpilogueTransaction)
    
    public var success: Bool {
        switch self {
        case .blockMetadataTransaction(let value):
            value.success
        case .genesisTransaction(let value):
            value.success
        case .pendingTransaction(_):
            false
        case .stateCheckpointTransaction(let value):
            value.success
        case .userTransaction(let value):
            value.success
        case .validatorTransaction(let value):
            value.success
        case .blockEpilogueTransaction(let value):
            value.success
        }
    }
    
    
    public var vmStatus: String {
        switch self {
        case .blockMetadataTransaction(let value):
            value.vmStatus
        case .genesisTransaction(let value):
            value.vmStatus
        case .pendingTransaction(_):
            ""
        case .stateCheckpointTransaction(let value):
            value.vmStatus
        case .userTransaction(let value):
            value.vmStatus
        case .validatorTransaction(let value):
            value.vmStatus
        case .blockEpilogueTransaction(let value):
            value.vmStatus
        }
    }

    public var version: String {
         switch self {
        case .blockMetadataTransaction(let value):
            value.version
        case .genesisTransaction(let value):
            value.version
        case .pendingTransaction(_):
            ""
        case .stateCheckpointTransaction(let value):
            value.version
        case .userTransaction(let value):
            value.version
        case .validatorTransaction(let value):
            value.version
        case .blockEpilogueTransaction(let value):
            value.version
        }
    }

    public var hash: String {
         switch self {
        case .blockMetadataTransaction(let value):
            value.hash
        case .genesisTransaction(let value):
            value.hash
        case .pendingTransaction(let value):
            value.hash
        case .stateCheckpointTransaction(let value):
            value.hash
        case .userTransaction(let value):
            value.hash
        case .validatorTransaction(let value):
            value.hash
        case .blockEpilogueTransaction(let value):
            value.hash
        }
    }
    
    
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
    }
    
    public init(from decoder: any Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(
            String.self,
            forKey: ._type
        )
        
        switch discriminator {
        case "block_metadata_transaction":
            self = .blockMetadataTransaction(try .init(from: decoder))
        case "genesis_transaction":
            self = .genesisTransaction(try .init(from: decoder))
        case "pending_transaction":
            self = .pendingTransaction(try .init(from: decoder))
        case "state_checkpoint_transaction":
            self = .stateCheckpointTransaction(try .init(from: decoder))
        case "user_transaction":
            self = .userTransaction(try .init(from: decoder))
        case "validator_transaction":
            self = .validatorTransaction(try .init(from: decoder))
        case "block_epilogue_transaction":
            self = .blockEpilogueTransaction(try .init(from: decoder))
        default:
            throw DecodingError.unknownOneOfDiscriminator(
                discriminatorKey: CodingKeys._type,
                discriminatorValue: discriminator,
                codingPath: decoder.codingPath
            )
        }
    }
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .blockMetadataTransaction(let value):
            try value.encode(to: encoder)
        case .genesisTransaction(let value):
            try value.encode(to: encoder)
        case .pendingTransaction(let value):
            try value.encode(to: encoder)
        case .stateCheckpointTransaction(let value):
            try value.encode(to: encoder)
        case .userTransaction(let value):
            try value.encode(to: encoder)
        case .validatorTransaction(let value):
            try value.encode(to: encoder)
        case .blockEpilogueTransaction(let value):
            try value.encode(to: encoder)
        }
    }

    public static func == (lhs: TransactionResponse, rhs: TransactionResponse) -> Bool {
        switch (lhs, rhs) {
        case (.blockMetadataTransaction(let lhsValue), .blockMetadataTransaction(let rhsValue)):
            return lhsValue == rhsValue
        case (.genesisTransaction(let lhsValue), .genesisTransaction(let rhsValue)):
            return lhsValue == rhsValue
        case (.pendingTransaction(let lhsValue), .pendingTransaction(let rhsValue)):
            return lhsValue == rhsValue
        case (.stateCheckpointTransaction(let lhsValue), .stateCheckpointTransaction(let rhsValue)):
            return lhsValue == rhsValue
        case (.userTransaction(let lhsValue), .userTransaction(let rhsValue)):
            return lhsValue == rhsValue
        case (.validatorTransaction(let lhsValue), .validatorTransaction(let rhsValue)):
            return lhsValue == rhsValue
        case (.blockEpilogueTransaction(let lhsValue), .blockEpilogueTransaction(let rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}

public struct BlockMetadataTransaction: Codable, Hashable, Sendable {
    
    public var version: String
    
    public var hash: String
    
    public var stateChangeHash: String
    
    public var eventRootHash: String
    
    public var stateCheckpointHash: String?
    
    public var gasUsed: String
    
    public var success: Bool
    
    public var vmStatus: String
    
    public var accumulatorRootHash: String
    
    public var changes: [WriteSetChange]
    
    public var id: String
    
    public var epoch: String
    
    public var round: String
    
    public var events: [Event]
    
    public var previousBlockVotesBitvec: [Int]
    
    public var proposer: String
    
    public var failedProposerIndices: [Int]
    
    public var timestamp: String
    
    public enum CodingKeys: String, CodingKey {
        case version
        case hash
        case stateChangeHash = "state_change_hash"
        case eventRootHash = "event_root_hash"
        case stateCheckpointHash = "state_checkpoint_hash"
        case gasUsed = "gas_used"
        case success
        case vmStatus = "vm_status"
        case accumulatorRootHash = "accumulator_root_hash"
        case changes
        case id
        case epoch
        case round
        case events
        case previousBlockVotesBitvec = "previous_block_votes_bitvec"
        case proposer
        case failedProposerIndices = "failed_proposer_indices"
        case timestamp
    }
}


public struct GenesisTransaction: Codable, Hashable, Sendable {
    
    public var version: String
    
    public var hash: String
    
    public var stateChangeHash: String
    
    public var eventRootHash: String
    
    public var stateCheckpointHash: String?
    
    public var gasUsed: String
    
    /// Whether the transaction was successful
    public var success: Bool
    
    /// The VM status of the transaction, can tell useful information in a failure
    public var vmStatus: String
    
    public var accumulatorRootHash: String
    
    /// Final state of resources changed by the transaction
    public var changes: [WriteSetChange]
    
    public var payload: GenesisPayload
    
    /// Events emitted during genesis
    public var events: [Event]
    
    public enum CodingKeys: String, CodingKey {
        case version
        case hash
        case stateChangeHash = "state_change_hash"
        case eventRootHash = "event_root_hash"
        case stateCheckpointHash = "state_checkpoint_hash"
        case gasUsed = "gas_used"
        case success
        case vmStatus = "vm_status"
        case accumulatorRootHash = "accumulator_root_hash"
        case changes
        case payload
        case events
    }
}

/// A transaction waiting in mempool
public struct PendingTransaction: Codable, Hashable, Sendable {

    public var hash: String
    
    public var sender: String
    
    public var sequenceNumber: String
    
    public var maxGasAmount: String
    
    public var gasUnitPrice: String
    
    public var expirationTimestampSecs: String
    
    public var payload: TransactionPayloadResponse
    
    public var signature: TransactionSignature?
    
    public enum CodingKeys: String, CodingKey {
        case hash
        case sender
        case sequenceNumber = "sequence_number"
        case maxGasAmount = "max_gas_amount"
        case gasUnitPrice = "gas_unit_price"
        case expirationTimestampSecs = "expiration_timestamp_secs"
        case payload
        case signature
    }
}

/// A state checkpoint transaction
public struct StateCheckpointTransaction: Codable, Hashable, Sendable {
    public var version: String
    public var hash: String
    public var stateChangeHash: String
    public var eventRootHash: String
    public var stateCheckpointHash: String?
    public var gasUsed: String
    /// Whether the transaction was successful
    public var success: Bool
    /// The VM status of the transaction, can tell useful information in a failure
    public var vmStatus: String
    public var accumulatorRootHash: String
    /// Final state of resources changed by the transaction
    public var changes: [WriteSetChange]
    public var timestamp: String
    
    public enum CodingKeys: String, CodingKey {
        case version
        case hash
        case stateChangeHash = "state_change_hash"
        case eventRootHash = "event_root_hash"
        case stateCheckpointHash = "state_checkpoint_hash"
        case gasUsed = "gas_used"
        case success
        case vmStatus = "vm_status"
        case accumulatorRootHash = "accumulator_root_hash"
        case changes
        case timestamp
    }
}

/// A transaction submitted by a user to change the state of the blockchain
///
/// - Remark: Generated from `#/components/schemas/UserTransaction`.
public struct UserTransaction: Codable, Hashable, Sendable {
    public var version: String
    public var hash: String
    public var stateChangeHash: String
    public var eventRootHash: String
    public var stateCheckpointHash: String?
    public var gasUsed: String
    /// Whether the transaction was successful
    public var success: Bool
    /// The VM status of the transaction, can tell useful information in a failure
    public var vmStatus: String
    public var accumulatorRootHash: String
    /// Final state of resources changed by the transaction
    public var changes: [WriteSetChange]
    
    public var sender: String
    
    public var sequenceNumber: String
    
    public var maxGasAmount: String
    
    public var gasUnitPrice: String
    
    public var expirationTimestampSecs: String
    
    public var payload: TransactionPayloadResponse
    
    public var signature: TransactionSignature?
    /// Events generated by the transaction
    public var events: [Event]
    public var timestamp: String
    
    public enum CodingKeys: String, CodingKey {
        case version
        case hash
        case stateChangeHash = "state_change_hash"
        case eventRootHash = "event_root_hash"
        case stateCheckpointHash = "state_checkpoint_hash"
        case gasUsed = "gas_used"
        case success
        case vmStatus = "vm_status"
        case accumulatorRootHash = "accumulator_root_hash"
        case changes
        case sender
        case sequenceNumber = "sequence_number"
        case maxGasAmount = "max_gas_amount"
        case gasUnitPrice = "gas_unit_price"
        case expirationTimestampSecs = "expiration_timestamp_secs"
        case payload
        case signature
        case events
        case timestamp
    }
}

public struct ValidatorTransaction: Codable, Hashable, Sendable {
    public var version: String
    public var hash: String
    public var stateChangeHash: String
    public var eventRootHash: String
    public var stateCheckpointHash: String?
    public var gasUsed: String
    /// Whether the transaction was successful
    public var success: Bool
    /// The VM status of the transaction, can tell useful information in a failure
    public var vmStatus: String
    public var accumulatorRootHash: String
    /// Final state of resources changed by the transaction
    public var changes: [WriteSetChange]
    public var events: [Event]
    public var timestamp: String

    public enum CodingKeys: String, CodingKey {
        case version
        case hash
        case stateChangeHash = "state_change_hash"
        case eventRootHash = "event_root_hash"
        case stateCheckpointHash = "state_checkpoint_hash"
        case gasUsed = "gas_used"
        case success
        case vmStatus = "vm_status"
        case accumulatorRootHash = "accumulator_root_hash"
        case changes
        case events
        case timestamp
    }
}

public struct BlockEpilogueTransaction: Codable, Hashable, Sendable {
    public var version: String
    public var hash: String
    public var stateChangeHash: String
    public var eventRootHash: String
    public var stateCheckpointHash: String?
    public var gasUsed: String
    /// Whether the transaction was successful
    public var success: Bool
    /// The VM status of the transaction, can tell useful information in a failure
    public var vmStatus: String
    public var accumulatorRootHash: String
    /// Final state of resources changed by the transaction
    public var changes: [WriteSetChange]
    public var timestamp: String

    // TODO: block_end_info
    // https://aptos.dev/en/build/apis/fullnode-rest-api-reference#model/blockepiloguetransaction
    
    public enum CodingKeys: String, CodingKey {
        case version
        case hash
        case stateChangeHash = "state_change_hash"
        case eventRootHash = "event_root_hash"
        case stateCheckpointHash = "state_checkpoint_hash"
        case gasUsed = "gas_used"
        case success
        case vmStatus = "vm_status"
        case accumulatorRootHash = "accumulator_root_hash"
        case changes
        case timestamp
    }
}

public enum WriteSetChange: Codable, Hashable, Sendable {
    case deleteModule(DeleteModule)
    case deleteResource(DeleteResource)
    case deleteTableItem(DeleteTableItem)
    case writeModule(WriteModule)
    case writeResource(WriteResource)
    case writeTableItem(WriteTableItem)
    
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(
            String.self,
            forKey: ._type
        )
        switch discriminator {
        case "delete_module":
            self = .deleteModule(try .init(from: decoder))
        case "delete_resource":
            self = .deleteResource(try .init(from: decoder))
        case "delete_table_item":
            self = .deleteTableItem(try .init(from: decoder))
        case "write_module":
            self = .writeModule(try .init(from: decoder))
        case "write_resource":
            self = .writeResource(try .init(from: decoder))
        case "write_table_item":
            self = .writeTableItem(try .init(from: decoder))
        default:
            throw DecodingError.unknownOneOfDiscriminator(
                discriminatorKey: CodingKeys._type,
                discriminatorValue: discriminator,
                codingPath: decoder.codingPath
            )
        }
    }
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case .deleteModule(let value):
            try value.encode(to: encoder)
        case .deleteResource(let value):
            try value.encode(to: encoder)
        case .deleteTableItem(let value):
            try value.encode(to: encoder)
        case .writeModule(let value):
            try value.encode(to: encoder)
        case .writeResource(let value):
            try value.encode(to: encoder)
        case .writeTableItem(let value):
            try value.encode(to: encoder)
        }
    }
}


public struct Event: Codable, Hashable, Sendable {
    public typealias Data = OpenAPIRuntime.OpenAPIValueContainer
    
    public var guid: EventGuid
    public var sequenceNumber: String
    public var type: String
    public var data: Event.Data
    
    public enum CodingKeys: String, CodingKey {
        case guid
        case sequenceNumber = "sequence_number"
        case type
        case data
    }
}

public struct EventGuid: Codable, Hashable, Sendable {
    public var creationNumber: String
    public var accountAddress: String
    
    public enum CodingKeys: String, CodingKey {
        case creationNumber = "creation_number"
        case accountAddress = "account_address"
    }
}

public struct DeleteModule: Codable, Hashable, Sendable {
    public var address: String
    /// State key hash
    public var stateKeyHash: String
    public var module: MoveModuleId
    
    public enum CodingKeys: String, CodingKey {
        case address
        case stateKeyHash = "state_key_hash"
        case module
    }
}

public struct DeleteResource: Codable, Hashable, Sendable {
    public var address: String
    /// State key hash
    public var stateKeyHash: String
    public var resource: MoveStructId
    
    public enum CodingKeys: String, CodingKey {
        case address
        case stateKeyHash = "state_key_hash"
        case resource
    }
}

/// Delete a table item
public struct DeleteTableItem: Codable, Hashable, Sendable {
    public var stateKeyHash: String
    
    public var handle: HexEncodedBytes
    
    public var key: HexEncodedBytes
    
    public var data: DeletedTableData?
    
    public enum CodingKeys: String, CodingKey {
        case stateKeyHash = "state_key_hash"
        case handle
        case key
        case data
    }
}

/// Deleted table data
public struct DeletedTableData: Codable, Hashable, Sendable {
    public typealias Key = OpenAPIRuntime.OpenAPIValueContainer
    
    public var key: Key
    
    public var keyType: String
    
    public enum CodingKeys: String, CodingKey {
        case key
        case keyType = "key_type"
    }
}

public struct WriteModule: Codable, Hashable, Sendable {
    public var address: String
    /// State key hash
    public var stateKeyHash: String
    
    public var data: MoveModuleBytecode
    
    public enum CodingKeys: String, CodingKey {
        case address
        case stateKeyHash = "state_key_hash"
        case data
    }
}
/// Write a resource or update an existing one
public struct WriteResource: Codable, Hashable, Sendable {
    public var address: String
    /// State key hash
    public var stateKeyHash: String
    public var data: MoveResource
    
    public enum CodingKeys: String, CodingKey {
        case address
        case stateKeyHash = "state_key_hash"
        case data
    }
}

public struct WriteTableItem: Codable, Hashable, Sendable {
    
    public var stateKeyHash: String
    
    public var handle: HexEncodedBytes
    
    public var key: HexEncodedBytes
    
    public var value: HexEncodedBytes
    
    public var data: DecodedTableData?
    
    public enum CodingKeys: String, CodingKey {
        case stateKeyHash = "state_key_hash"
        case handle
        case key
        case value
        case data
    }
}

public struct DecodedTableData: Codable, Hashable, Sendable {
    public typealias Key = OpenAPIRuntime.OpenAPIValueContainer
    public typealias Value = OpenAPIRuntime.OpenAPIValueContainer
    
    /// Key of table in JSON
    public var key: Key
    /// Type of key
    public var keyType: String
    /// Value of table in JSON
    public var value: Value
    /// Type of value
    public var valueType: String
    
    public enum CodingKeys: String, CodingKey {
        case key
        case keyType = "key_type"
        case value
        case valueType = "value_type"
    }
}

public enum GenesisPayload: Codable, Hashable, Sendable {
    
    case writeSetPayload(WriteSetPayload)
    
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
    }
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(
            String.self,
            forKey: ._type
        )
        switch discriminator {
        case "write_set_payload":
            self = .writeSetPayload(try .init(from: decoder))
        default:
            throw DecodingError.unknownOneOfDiscriminator(
                discriminatorKey: CodingKeys._type,
                discriminatorValue: discriminator,
                codingPath: decoder.codingPath
            )
        }
    }
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case let .writeSetPayload(value):
            try value.encode(to: encoder)
        }
    }
}

/// A writeset payload, used only for genesis
public struct WriteSetPayload: Codable, Hashable, Sendable {
    
    public var writeSet: WriteSet
    
    public enum CodingKeys: String, CodingKey {
        case writeSet = "write_set"
    }
}

public enum WriteSet: Codable, Hashable, Sendable {
    case directWriteSet(DirectWriteSet)
    case scriptWriteSet(ScriptWriteSet)
    
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(
            String.self,
            forKey: ._type
        )
        switch discriminator {
        case "direct_write_set":
            self = .directWriteSet(try .init(from: decoder))
        case "script_write_set":
            self = .scriptWriteSet(try .init(from: decoder))
        default:
            throw DecodingError.unknownOneOfDiscriminator(
                discriminatorKey: CodingKeys._type,
                discriminatorValue: discriminator,
                codingPath: decoder.codingPath
            )
        }
    }
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case let .directWriteSet(value):
            try value.encode(to: encoder)
        case let .scriptWriteSet(value):
            try value.encode(to: encoder)
        }
    }
}

public struct DirectWriteSet: Codable, Hashable, Sendable {
    
    public var changes: [WriteSetChange]
    
    public var events: [Event]
    
    public enum CodingKeys: String, CodingKey {
        case changes
        case events
    }
}

public struct ScriptWriteSet: Codable, Hashable, Sendable {
    public var executeAs: String
    public var script: TransactionPayloadResponse.Script
    
    public enum CodingKeys: String, CodingKey {
        case executeAs = "execute_as"
        case script
    }
}

/// Move script bytecode
public struct MoveScriptBytecode: Codable, Hashable, Sendable {
    public var bytecode: HexEncodedBytes
    public var abi: MoveFunction?
    
    public enum CodingKeys: String, CodingKey {
        case bytecode
        case abi
    }
}

/// A move struct
public struct MoveStruct: Codable, Hashable, Sendable {
    
    public var name: IdentifierWrapper
    /// Whether the struct is a native struct of Move
    public var isNative: Bool
    
    /// Abilities associated with the struct
    public var abilities: [MoveAbility]
    /// Generic types associated with the struct
    public var genericTypeParams: [MoveStructGenericTypeParam]
    /// Fields associated with the struct
    public var fields: [MoveStructField]
    
    public enum CodingKeys: String, CodingKey {
        case name
        case isNative = "is_native"
        case abilities
        case genericTypeParams = "generic_type_params"
        case fields
    }
}

/// An enum of the possible transaction payloads
public enum TransactionPayloadResponse: Codable, Hashable, Sendable {
    public typealias DeprecatedModuleBundlePayload = OpenAPIRuntime.OpenAPIObjectContainer
    
    case entryFunctionPayload(EntryFunction)
    
    case moduleBundlePayload(DeprecatedModuleBundlePayload)
    
    case multisigPayload(Multisig)
    
    case scriptPayload(Script)
    
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(
            Swift.String.self,
            forKey: ._type
        )
        switch discriminator {
        case "entry_function_payload":
            self = .entryFunctionPayload(try .init(from: decoder))
        case "module_bundle_payload":
            self = .moduleBundlePayload(try .init(from: decoder))
        case "multisig_payload":
            self = .multisigPayload(try .init(from: decoder))
        case "script_payload":
            self = .scriptPayload(try .init(from: decoder))
        default:
            throw DecodingError.unknownOneOfDiscriminator(
                discriminatorKey: CodingKeys._type,
                discriminatorValue: discriminator,
                codingPath: decoder.codingPath
            )
        }
    }
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case let .entryFunctionPayload(value):
            try value.encode(to: encoder)
        case let .moduleBundlePayload(value):
            try value.encode(to: encoder)
        case let .multisigPayload(value):
            try value.encode(to: encoder)
        case let .scriptPayload(value):
            try value.encode(to: encoder)
        }
    }
}


extension TransactionPayloadResponse {

/// Payload which runs a single entry function
public struct EntryFunction: Codable, Hashable, Sendable {
    public typealias Argument = OpenAPIRuntime.OpenAPIValueContainer
    public var function: EntryFunctionId
    /// Type arguments of the function
    public var typeArguments: [String]
    /// Arguments of the function
    public var arguments: [EntryFunction.Argument]
    
    public enum CodingKeys: String, CodingKey {
        case function
        case typeArguments = "type_arguments"
        case arguments
    }
}


/// Payload which runs a script that can run multiple functions
public struct Script: Codable, Hashable, Sendable {
    public typealias Argument = OpenAPIRuntime.OpenAPIValueContainer
    public var code: MoveScriptBytecode
    /// Type arguments of the function
    public var typeArguments: [String]
    /// Arguments of the function
    public var arguments: [Script.Argument]
    
    public enum CodingKeys: String, CodingKey {
        case code
        case typeArguments = "type_arguments"
        case arguments
    }
}

/// A multisig transaction that allows an owner of a multisig account to execute a pre-approved
/// transaction as the multisig account.
public struct Multisig: Codable, Hashable, Sendable {
    
    public var multisigAddress: String
    
    public var transactionPayload: TransactionPayloadResponse.Multisig.Transaction?
    
    public enum CodingKeys: String, CodingKey {
        case multisigAddress = "multisig_address"
        case transactionPayload = "transaction_payload"
    }
}


}

extension TransactionPayloadResponse.Multisig {

    public enum Transaction: Codable, Hashable, Sendable {
        case entryFunctionPayload(TransactionPayloadResponse.EntryFunction)
        
        public enum CodingKeys: String, CodingKey {
            case _type = "type"
        }
        
        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let discriminator = try container.decode(
                Swift.String.self,
                forKey: ._type
            )
            switch discriminator {
            case "entry_function_payload":
                self = .entryFunctionPayload(try .init(from: decoder))
            default:
                throw DecodingError.unknownOneOfDiscriminator(
                    discriminatorKey: CodingKeys._type,
                    discriminatorValue: discriminator,
                    codingPath: decoder.codingPath
                )
            }
        }
        public func encode(to encoder: any Encoder) throws {
            switch self {
            case let .entryFunctionPayload(value):
                try value.encode(to: encoder)
            }
        }
    }
}

public enum TransactionSignature: Codable, Hashable, Sendable {
    case ed25519(Ed25519Signature)
    case feePayer(FeePayerSignature)
    case multiAgent(MultiAgentSignature)
    case multiEd25519(MultiEd25519Signature)
    case singleSender(AccountSignature)
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(
            Swift.String.self,
            forKey: ._type
        )
        switch discriminator {
        case "ed25519_signature":
            self = .ed25519(try .init(from: decoder))
        case "fee_payer_signature":
            self = .feePayer(try .init(from: decoder))
        case "multi_agent_signature":
            self = .multiAgent(try .init(from: decoder))
        case "multi_ed25519_signature":
            self = .multiEd25519(try .init(from: decoder))
        case "single_sender":
            self = .singleSender(try .init(from: decoder))
        default:
            throw DecodingError.unknownOneOfDiscriminator(
                discriminatorKey: CodingKeys._type,
                discriminatorValue: discriminator,
                codingPath: decoder.codingPath
            )
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case let .ed25519(value):
            try value.encode(to: encoder)
        case let .feePayer(value):
            try value.encode(to: encoder)
        case let .multiAgent(value):
            try value.encode(to: encoder)
        case let .multiEd25519(value):
            try value.encode(to: encoder)
        case let .singleSender(value):
            try value.encode(to: encoder)
        }
    }


    /// A single Ed25519 signature
    public struct Ed25519Signature: Codable, Hashable, Sendable {
        
        public var publicKey: HexEncodedBytes
        
        public var signature: HexEncodedBytes
        
        public enum CodingKeys: String, CodingKey {
            case publicKey = "public_key"
            case signature
        }
    }

    /// Fee payer signature for fee payer transactions
    ///
    /// This allows you to have transactions across multiple accounts and with a fee payer
    public struct FeePayerSignature: Codable, Hashable, Sendable {
        
        public var sender: AccountSignature
        /// The other involved parties' addresses
        public var secondarySignerAddresses: [String]
        /// The associated signatures, in the same order as the secondary addresses
        public var secondarySigners: [AccountSignature]
        
        public var feePayerAddress: String
        
        public var feePayerSigner: AccountSignature
        
        public enum CodingKeys: String, CodingKey {
            case sender
            case secondarySignerAddresses = "secondary_signer_addresses"
            case secondarySigners = "secondary_signers"
            case feePayerAddress = "fee_payer_address"
            case feePayerSigner = "fee_payer_signer"
        }
    }

    /// Multi agent signature for multi agent transactions
    ///
    /// This allows you to have transactions across multiple accounts
    public struct MultiAgentSignature: Codable, Hashable, Sendable {
        public var sender: AccountSignature
        /// The other involved parties' addresses
        public var secondarySignerAddresses: [String]
        /// The associated signatures, in the same order as the secondary addresses
        ///
        /// - Remark: Generated from `#/components/schemas/MultiAgentSignature/secondary_signers`.
        public var secondarySigners: [AccountSignature]
        
        public enum CodingKeys: String, CodingKey {
            case sender
            case secondarySignerAddresses = "secondary_signer_addresses"
            case secondarySigners = "secondary_signers"
        }
    }

    /// A Ed25519 multi-sig signature
    ///
    /// This allows k-of-n signing for a transaction
    public struct MultiEd25519Signature: Codable, Hashable, Sendable {
        /// The public keys for the Ed25519 signature
        public var publicKeys: [HexEncodedBytes]
        /// Signature associated with the public keys in the same order
        public var signatures: [HexEncodedBytes]
        /// The number of signatures required for a successful transaction
        public var threshold: Int
        public var bitmap: HexEncodedBytes
        
        public enum CodingKeys: String, CodingKey {
            case publicKeys = "public_keys"
            case signatures
            case threshold
            case bitmap
        }
    }

    /// A multi key signature
    public struct MultiKeySignature: Codable, Hashable, Sendable {
        public var signatures: [IndexedSignature]
        public var signaturesRequired: Int
        
        public enum CodingKeys: String, CodingKey {
            case signatures
            case signaturesRequired = "signatures_required"
        }
    }


    /// A single key signature
    public struct SingleKeySignature: Codable, Hashable, Sendable {
        
        public var publicKey: HexEncodedBytes
        public var signature: HexEncodedBytes
        
        public enum CodingKeys: String, CodingKey {
            case publicKey = "public_key"
            case signature
        }
    }

    public struct IndexedSignature: Codable, Hashable, Sendable {
        public var index: Int
        public enum CodingKeys: String, CodingKey {
            case index
        }
    }
}


/// Account signature scheme
///
/// The account signature scheme allows you to have two types of accounts:
///
/// 1. A single Ed25519 key account, one private key
/// 2. A k-of-n multi-Ed25519 key account, multiple private keys, such that k-of-n must sign a transaction.
/// 3. A single Secp256k1Ecdsa key account, one private key
public enum AccountSignature: Codable, Hashable, Sendable {
    case ed25519(TransactionSignature.Ed25519Signature)
    case multiEd25519(TransactionSignature.MultiEd25519Signature)
    case multiKey(TransactionSignature.MultiKeySignature)
    case singleKey(TransactionSignature.SingleKeySignature)
    
    public enum CodingKeys: String, CodingKey {
        case _type = "type"
    }
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminator = try container.decode(
            Swift.String.self,
            forKey: ._type
        )
        switch discriminator {
        case "ed25519_signature":
            self = .ed25519(try .init(from: decoder))
        case "multi_ed25519_signature":
            self = .multiEd25519(try .init(from: decoder))
        case "multi_key_signature":
            self = .multiKey(try .init(from: decoder))
        case "single_key_signature":
            self = .singleKey(try .init(from: decoder))
        default:
            throw DecodingError.unknownOneOfDiscriminator(
                discriminatorKey: CodingKeys._type,
                discriminatorValue: discriminator,
                codingPath: decoder.codingPath
            )
        }
    }
    public func encode(to encoder: any Encoder) throws {
        switch self {
        case let .ed25519(value):
            try value.encode(to: encoder)
        case let .multiEd25519(value):
            try value.encode(to: encoder)
        case let .multiKey(value):
            try value.encode(to: encoder)
        case let .singleKey(value):
            try value.encode(to: encoder)
        }
    }
}


/// Struct holding the outputs of the estimate gas API
public struct GasEstimation: Codable, Hashable, Sendable {
    /// The deprioritized estimate for the gas unit price
    public var deprioritizedGasEstimate: Int?
    /// The current estimate for the gas unit price
    public var gasEstimate: UInt64
    /// The prioritized estimate for the gas unit price
    public var prioritizedGasEstimate: Int?
    
    public enum CodingKeys: String, CodingKey {
        case deprioritizedGasEstimate = "deprioritized_gas_estimate"
        case gasEstimate = "gas_estimate"
        case prioritizedGasEstimate = "prioritized_gas_estimate"
    }
}



public enum AuthenticationKeyScheme: Sendable {
    case signing(SigningScheme)
    case derive(DeriveScheme)

    public var rawValue: Int {
        switch self {
        case .signing(let scheme):
            return scheme.rawValue
        case .derive(let scheme):
            return scheme.rawValue
        }
    }
}


public enum DeriveScheme: Int, Sendable {
    /// Derives an address using an AUID, used for objects
    case auid = 251
    /// Derives an address from another object address
    case object = 252
    /// Derives an address from a GUID, used for objects
    case guid = 253
    /// Derives an address from seed bytes, used for named objects
    case seed = 254
    /// Derives an address from seed bytes, used for resource accounts
    case resource = 255
}

public enum SigningScheme : Int, Sendable {
    /// For Ed25519PublicKey
    case ed25519 = 0
    /// For MultiEd25519PublicKey
    case multiEd25519 = 1
    /// For SingleKey ecdsa
    case singleKey = 2
    /// For MultiKey ecdsa
    case multiKey = 3
}

public enum SigningSchemeInput: Int, Sendable {
  /// For Ed25519PublicKey
  case ed25519 = 0
    /// For Secp256k1Ecdsa
  case secp256k1Ecdsa = 2
}

public enum AnyPublicKeyVariant: UInt32, Sendable {
    case ed25519 = 0
    case secp256k1 = 1
}

public enum AnySignatureVariant: UInt32, Sendable {
    case ed25519 = 0
    case secp256k1 = 1
}

public enum RoleType: String, Codable, Sendable {
    case validator
    case fullNode = "full_node"
}
public struct LedgerInfo: Codable, Sendable {
    public var chainId: UInt8
    public var epoch: String
    public var ledgerVersion: String
    public var oldestLedgerVersion: String
    public var ledgerTimestamp: String
    public var nodeRole: RoleType
    public var oldestBlockHeight: String
    public var blockHeight: String
    public var gitHash: String?

    public enum CodingKeys: String, CodingKey {
        case chainId = "chain_id"
        case epoch = "epoch"
        case ledgerVersion = "ledger_version"
        case oldestLedgerVersion = "oldest_ledger_version"
        case ledgerTimestamp = "ledger_timestamp"
        case nodeRole = "node_role"
        case oldestBlockHeight = "oldest_block_height"
        case blockHeight = "block_height"
        case gitHash = "git_hash"
    }
}

public struct Block: Codable, Sendable {
    public var blockHeight: String
    public var blockHash: String
    public var blockTimestamp: String
    public var firstVersion: String
    public var lastVersion: String
    public var transactions: [TransactionResponse]?

    public enum CodingKeys: String, CodingKey {
        case blockHeight = "block_height"
        case blockHash = "block_hash"
        case blockTimestamp = "block_timestamp"
        case firstVersion = "first_version"
        case lastVersion = "last_version"
        case transactions = "transactions"
    }
}

public struct TableItemRequest: Sendable {
    public var keyType: MoveType
    public var valueType: MoveValue
    public var key: Codable & Sendable

    public init(keyType: MoveType, valueType: MoveValue, key: Codable & Sendable) {
        self.keyType = keyType
        self.valueType = valueType
        self.key = key
    }

    public var json: [String: Sendable] {
        return [
            "key_type": keyType,
            "value_type": valueType,
            "key": key
        ]
    }
}




