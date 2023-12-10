# Configuration passed to zot serve
type Zot::Config = Struct[{
  Optional[distSpecVersion] => String[1],
  Optional[storage]         => Hash,
  Optional[http]            => Hash,
  Optional[log]             => Hash,
  Optional[extensions]      => Hash,
  Optional[scheduler]       => Hash,
}]
