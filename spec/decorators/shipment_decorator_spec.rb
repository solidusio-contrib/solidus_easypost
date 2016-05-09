[Cassette: 'create_easypost_shipment'] Initialized with options: {:record=>:once, :match_requests_on=>[:method, :uri], :allow_unused_http_interactions=>true, :serialize_with=>:yaml, :persist_with=>:file_system}
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Initialized HTTPInteractionList with request matchers [:method, :uri] and 4 interaction(s): { [post https://api.easypost.com/v2/addresses] => [201 "{\"id\":\"adr_c8312687951b4bfb84c64d674148a3ee\",\"object\":\"Address\",\"created_at\":\"20"], [post https://api.easypost.com/v2/addresses] => [201 "{\"id\":\"adr_bb632a60c8214a869d8bd6c55e0d5d1e\",\"object\":\"Address\",\"created_at\":\"20"], [post https://api.easypost.com/v2/parcels] => [201 "{\"id\":\"prcl_abcaadff158242179cd284c64a7c0e1b\",\"object\":\"Parcel\",\"created_at\":\"20"], [post https://api.easypost.com/v2/shipments] => [201 "{\"created_at\":\"2016-05-09T18:15:18Z\",\"is_return\":false,\"messages\":[],\"mode\":\"tes"] }
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/addresses] at index 0: [201 "{\"id\":\"adr_c8312687951b4bfb84c64d674148a3ee\",\"object\":\"Address\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/addresses] at index 0: [201 "{\"id\":\"adr_bb632a60c8214a869d8bd6c55e0d5d1e\",\"object\":\"Address\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/parcels] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/parcels] matches [post https://api.easypost.com/v2/parcels] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/parcels] at index 0: [201 "{\"id\":\"prcl_abcaadff158242179cd284c64a7c0e1b\",\"object\":\"Parcel\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/parcels]
[Cassette: 'create_easypost_shipment'] Initialized with options: {:record=>:once, :match_requests_on=>[:method, :uri], :allow_unused_http_interactions=>true, :serialize_with=>:yaml, :persist_with=>:file_system, :allow_playback_repeats=>true}
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Initialized HTTPInteractionList with request matchers [:method, :uri] and 4 interaction(s): { [post https://api.easypost.com/v2/addresses] => [201 "{\"id\":\"adr_c8312687951b4bfb84c64d674148a3ee\",\"object\":\"Address\",\"created_at\":\"20"], [post https://api.easypost.com/v2/addresses] => [201 "{\"id\":\"adr_bb632a60c8214a869d8bd6c55e0d5d1e\",\"object\":\"Address\",\"created_at\":\"20"], [post https://api.easypost.com/v2/parcels] => [201 "{\"id\":\"prcl_abcaadff158242179cd284c64a7c0e1b\",\"object\":\"Parcel\",\"created_at\":\"20"], [post https://api.easypost.com/v2/shipments] => [201 "{\"created_at\":\"2016-05-09T18:15:18Z\",\"is_return\":false,\"messages\":[],\"mode\":\"tes"] }
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/addresses] at index 0: [201 "{\"id\":\"adr_c8312687951b4bfb84c64d674148a3ee\",\"object\":\"Address\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/addresses] at index 0: [201 "{\"id\":\"adr_bb632a60c8214a869d8bd6c55e0d5d1e\",\"object\":\"Address\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/parcels] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/parcels] matches [post https://api.easypost.com/v2/parcels] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/parcels] at index 0: [201 "{\"id\":\"prcl_abcaadff158242179cd284c64a7c0e1b\",\"object\":\"Parcel\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/parcels]
[webmock] Handling request: [post https://api.easypost.com/v2/shipments] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/shipments] matches [post https://api.easypost.com/v2/shipments] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/shipments] vs [post https://api.easypost.com/v2/shipments]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/shipments] vs [post https://api.easypost.com/v2/shipments]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/shipments] at index 0: [201 "{\"created_at\":\"2016-05-09T18:15:18Z\",\"is_return\":false,\"messages\":[],\"mode\":\"tes"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/shipments]
[Cassette: 'find_easypost_shipment'] Initialized with options: {:record=>:once, :match_requests_on=>[:method, :uri], :allow_unused_http_interactions=>true, :serialize_with=>:yaml, :persist_with=>:file_system}
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'find_easypost_shipment'] Initialized HTTPInteractionList with request matchers [:method, :uri] and 4 interaction(s): { [post https://api.easypost.com/v2/addresses] => [201 "{\"id\":\"adr_2554ada92956412ebb2e041763dd781c\",\"object\":\"Address\",\"created_at\":\"20"], [post https://api.easypost.com/v2/addresses] => [201 "{\"id\":\"adr_5ce0589fad0646809c768068053ecf11\",\"object\":\"Address\",\"created_at\":\"20"], [post https://api.easypost.com/v2/parcels] => [201 "{\"id\":\"prcl_c77b7949ffb543f3b9fa5439d6a091d4\",\"object\":\"Parcel\",\"created_at\":\"20"], [post https://api.easypost.com/v2/shipments] => [201 "{\"created_at\":\"2016-05-09T18:15:56Z\",\"is_return\":false,\"messages\":[],\"mode\":\"tes"] }
  [Cassette: 'find_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'find_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'find_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
  [Cassette: 'find_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/addresses] at index 0: [201 "{\"id\":\"adr_2554ada92956412ebb2e041763dd781c\",\"object\":\"Address\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'find_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'find_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'find_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
  [Cassette: 'find_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/addresses] at index 0: [201 "{\"id\":\"adr_5ce0589fad0646809c768068053ecf11\",\"object\":\"Address\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/parcels] (disabled: false)
  [Cassette: 'find_easypost_shipment'] Checking if [post https://api.easypost.com/v2/parcels] matches [post https://api.easypost.com/v2/parcels] using [:method, :uri]
    [Cassette: 'find_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
    [Cassette: 'find_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
  [Cassette: 'find_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/parcels] at index 0: [201 "{\"id\":\"prcl_c77b7949ffb543f3b9fa5439d6a091d4\",\"object\":\"Parcel\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/parcels]
[webmock] Handling request: [post https://api.easypost.com/v2/shipments] (disabled: false)
  [Cassette: 'find_easypost_shipment'] Checking if [post https://api.easypost.com/v2/shipments] matches [post https://api.easypost.com/v2/shipments] using [:method, :uri]
    [Cassette: 'find_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/shipments] vs [post https://api.easypost.com/v2/shipments]
    [Cassette: 'find_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/shipments] vs [post https://api.easypost.com/v2/shipments]
  [Cassette: 'find_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/shipments] at index 0: [201 "{\"created_at\":\"2016-05-09T18:15:56Z\",\"is_return\":false,\"messages\":[],\"mode\":\"tes"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/shipments]
[Cassette: 'create_easypost_shipment'] Initialized with options: {:record=>:once, :match_requests_on=>[:method, :uri], :allow_unused_http_interactions=>true, :serialize_with=>:yaml, :persist_with=>:file_system, :allow_playback_repeats=>true}
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Initialized HTTPInteractionList with request matchers [:method, :uri] and 4 interaction(s): { [post https://api.easypost.com/v2/addresses] => [201 "{\"id\":\"adr_c8312687951b4bfb84c64d674148a3ee\",\"object\":\"Address\",\"created_at\":\"20"], [post https://api.easypost.com/v2/addresses] => [201 "{\"id\":\"adr_bb632a60c8214a869d8bd6c55e0d5d1e\",\"object\":\"Address\",\"created_at\":\"20"], [post https://api.easypost.com/v2/parcels] => [201 "{\"id\":\"prcl_abcaadff158242179cd284c64a7c0e1b\",\"object\":\"Parcel\",\"created_at\":\"20"], [post https://api.easypost.com/v2/shipments] => [201 "{\"created_at\":\"2016-05-09T18:15:18Z\",\"is_return\":false,\"messages\":[],\"mode\":\"tes"] }
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/addresses] at index 0: [201 "{\"id\":\"adr_c8312687951b4bfb84c64d674148a3ee\",\"object\":\"Address\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/addresses] at index 0: [201 "{\"id\":\"adr_bb632a60c8214a869d8bd6c55e0d5d1e\",\"object\":\"Address\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/parcels] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/parcels] matches [post https://api.easypost.com/v2/parcels] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/parcels] at index 0: [201 "{\"id\":\"prcl_abcaadff158242179cd284c64a7c0e1b\",\"object\":\"Parcel\",\"created_at\":\"20"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/parcels]
[webmock] Handling request: [post https://api.easypost.com/v2/shipments] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/shipments] matches [post https://api.easypost.com/v2/shipments] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/shipments] vs [post https://api.easypost.com/v2/shipments]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/shipments] vs [post https://api.easypost.com/v2/shipments]
  [Cassette: 'create_easypost_shipment'] Found matching interaction for [post https://api.easypost.com/v2/shipments] at index 0: [201 "{\"created_at\":\"2016-05-09T18:15:18Z\",\"is_return\":false,\"messages\":[],\"mode\":\"tes"]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/shipments]
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/shipments] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/shipments]
    [Cassette: 'create_easypost_shipment'] uri (did not match): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/shipments]
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/parcels] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/parcels]
    [Cassette: 'create_easypost_shipment'] uri (did not match): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/parcels]
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/addresses] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/shipments] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/shipments]
    [Cassette: 'create_easypost_shipment'] uri (did not match): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/shipments]
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/parcels] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/parcels]
    [Cassette: 'create_easypost_shipment'] uri (did not match): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/parcels]
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/addresses] matches [post https://api.easypost.com/v2/addresses] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/addresses] vs [post https://api.easypost.com/v2/addresses]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/addresses]
[webmock] Handling request: [post https://api.easypost.com/v2/parcels] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/parcels] matches [post https://api.easypost.com/v2/shipments] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/shipments]
    [Cassette: 'create_easypost_shipment'] uri (did not match): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/shipments]
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/parcels] matches [post https://api.easypost.com/v2/parcels] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/parcels] vs [post https://api.easypost.com/v2/parcels]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/parcels]
[webmock] Handling request: [post https://api.easypost.com/v2/shipments] (disabled: false)
  [Cassette: 'create_easypost_shipment'] Checking if [post https://api.easypost.com/v2/shipments] matches [post https://api.easypost.com/v2/shipments] using [:method, :uri]
    [Cassette: 'create_easypost_shipment'] method (matched): current request [post https://api.easypost.com/v2/shipments] vs [post https://api.easypost.com/v2/shipments]
    [Cassette: 'create_easypost_shipment'] uri (matched): current request [post https://api.easypost.com/v2/shipments] vs [post https://api.easypost.com/v2/shipments]
[webmock] Identified request type (stubbed_by_vcr) for [post https://api.easypost.com/v2/shipments]
