package mtproto

import (
	"fmt"
	"github.com/golang/glog"
)
//type newTLObjectFunc func() TLObject
type TLObjectHelper struct {
	newTLObjectFunc func() TLObject
	layer           int
	classIdList     []int32
}

var registers2 = map[int32]TLObjectHelper{
    int32(TLConstructor_CRC32_message2) : TLObjectHelper{newTLObjectFunc: func() (TLObject) { return &TLMessage2{} }, layer: 0, classIdList: []int32{}},
    int32(TLConstructor_CRC32_msg_container) : TLObjectHelper{newTLObjectFunc: func() (TLObject) { return &TLMsgContainer{} }, layer: 0, classIdList: []int32{}},
    int32(TLConstructor_CRC32_msg_copy) : TLObjectHelper{newTLObjectFunc: func() (TLObject) { return &TLMsgCopy{} }, layer: 0, classIdList: []int32{}},
    int32(TLConstructor_CRC32_gzip_packed) : TLObjectHelper{newTLObjectFunc: func() (TLObject) { return &TLGzipPacked{} }, layer: 0, classIdList: []int32{}},
    int32(TLConstructor_CRC32_rpc_result) : TLObjectHelper{newTLObjectFunc: func() (TLObject) { return &TLRpcResult{} }, layer: 0, classIdList: []int32{}},
{{ range .CRC32List }}    int32(TLConstructor_CRC32_{{.Name}}): TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTL{{.Type}}() }, layer: 99, classIdList: []int32{ {{.Id}} }},
{{end}}
  int32(TLConstructor_CRC32_rsa_public_key):                                   TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLRsaPublicKey() }, layer: 85, classIdList: []int32{2048510838}},
	int32(TLConstructor_CRC32_sessionClientCreated):                             TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionClientCreated() }, layer: 85, classIdList: []int32{-1623878595}},
	int32(TLConstructor_CRC32_sessionClientClosed):                              TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionClientClosed() }, layer: 85, classIdList: []int32{1523187533}},
	int32(TLConstructor_CRC32_handshakeContext):                                 TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLHandshakeContext() }, layer: 85, classIdList: []int32{-1368942052}},
	int32(TLConstructor_CRC32_handshakeData):                                    TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLHandshakeData() }, layer: 85, classIdList: []int32{296397831}},
	int32(TLConstructor_CRC32_sessionMessageData):                               TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionMessageData() }, layer: 85, classIdList: []int32{-1817881259}},
	int32(TLConstructor_CRC32_chatData):                                         TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLChatData() }, layer: 85, classIdList: []int32{308598610}},
	int32(TLConstructor_CRC32_int32):                                            TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLInt32() }, layer: 85, classIdList: []int32{-1932527041}},
	int32(TLConstructor_CRC32_long):                                             TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLLong() }, layer: 85, classIdList: []int32{1253220205}},
	int32(TLConstructor_CRC32_string):                                           TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLString() }, layer: 85, classIdList: []int32{194458693}},
	int32(TLConstructor_CRC32_authKeyInfo):                                      TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLAuthKeyInfo() }, layer: 85, classIdList: []int32{-793297679}},
	int32(TLConstructor_CRC32_clientSessionInfo):                                TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLClientSessionInfo() }, layer: 85, classIdList: []int32{167005722}},
	int32(TLConstructor_CRC32_push_sessionServerConnected):                      TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLPushSessionServerConnected() }, layer: 85, classIdList: []int32{575607369}},
	int32(TLConstructor_CRC32_session_setClientSessionInfo):                     TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionSetClientSessionInfo() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_getAuthorizations):                        TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionGetAuthorizations() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_resetAuthorization):                       TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionResetAuthorization() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_getLayer):                                 TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionGetLayer() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_getLangCode):                              TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionGetLangCode() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_getUserId):                                TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionGetUserId() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_getPushSessionId):                         TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionGetPushSessionId() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_getFutureSalts):                           TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionGetFutureSalts() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_queryAuthKey):                             TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionQueryAuthKey() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_setAuthKey):                               TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionSetAuthKey() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_bindAuthKeyUser):                          TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionBindAuthKeyUser() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_session_unbindAuthKeyUser):                        TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSessionUnbindAuthKeyUser() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_sync_syncUpdates):                                 TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSyncSyncUpdates() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_sync_pushUpdates):                                 TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSyncPushUpdates() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_sync_syncChannelUpdates):                          TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSyncSyncChannelUpdates() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_sync_pushChannelUpdates):                          TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSyncPushChannelUpdates() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_sync_pushRpcResult):                               TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSyncPushRpcResult() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_sync_getState):                                    TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSyncGetState() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_sync_getDifference):                               TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSyncGetDifference() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_sync_getChannelDifference):                        TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLSyncGetChannelDifference() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_push_connectToSessionServer):                      TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLPushConnectToSessionServer() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_push_pushUpdatesData):                             TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLPushPushUpdatesData() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_push_pushRpcResultData):                           TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLPushPushRpcResultData() }, layer: 85, classIdList: []int32{}},
	int32(TLConstructor_CRC32_bot_executeCommand):                               TLObjectHelper{newTLObjectFunc: func() TLObject { return NewTLBotExecuteCommand() }, layer: 85, classIdList: []int32{}},
}

func NewTLObjectByClassID(classId int32) TLObject {
	m, ok := registers2[classId]
	if !ok {
		return nil
	}
	return m.newTLObjectFunc()
}

func CheckClassID(classId int32) (ok bool) {
	_, ok = registers2[classId]
	return
}

func getConstructorByLayer(classId TLConstructor, layer int) TLConstructor {
	if m, ok := registers2[int32(classId)]; ok {
		classIdList := m.classIdList
		for _, c := range classIdList {
			if m, ok := registers2[int32(c)]; ok {
				if m.layer == layer {
					return TLConstructor(c)
				}
			}
		}
	}
	return classId
}
//////////////////////////////////////////////////////////////////////////////////////////
func (m *TLFutureSalt) EncodeIgnore() []byte {
	x := NewEncodeBuf(512)
	// x.Int(int32(TLConstructor_CRC32_future_salt))

	x.Int(m.GetValidSince())
	x.Int(m.GetValidUntil())
	x.Long(m.GetSalt())

	return x.buf
}

func (m *TLFutureSalt) EncodeToLayerIgnore(layer int) []byte {
	x := NewEncodeBuf(512)
	// x.Int(int32(TLConstructor_CRC32_future_salt))

	x.Int(m.GetValidSince())
	x.Int(m.GetValidUntil())
	x.Long(m.GetSalt())

	return x.buf
}

//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

{{ range .BaseTypeList }}
///////////////////////////////////////////////////////////////////////////////
// {{.Name}} <--
{{ range .SubMessageList }}//  + TL_{{.Name}}
{{end}}//

func (m *{{.Name}}) Encode() []byte {
    switch m.GetConstructor() {
{{ range $i, $v := .SubMessageList }}    case TLConstructor_CRC32_{{.Predicate}}:
        t := m.To_{{.Name}}()
        return t.Encode()
{{end}}
    default:
        glog.Error("Constructor error: ",  m.GetConstructor())
        return nil
    }
}

func (m *{{.Name}}) EncodeToLayer(layer int) []byte {
    classId := getConstructorByLayer(m.GetConstructor(), layer)
    switch classId {
{{ range $i, $v := .SubMessageList }}    case TLConstructor_CRC32_{{.Predicate}}:
        t := m.To_{{.Name}}()
        return t.EncodeToLayer(layer)
{{end}}
    default:
        glog.Error("Constructor error: ",  m.GetConstructor())
        return nil
    }
}


func (m *{{.Name}}) Decode(dbuf *DecodeBuf) error {
    m.Constructor = TLConstructor(dbuf.Int())
    switch m.Constructor {
{{ range $i, $v := .SubMessageList }}    case TLConstructor_CRC32_{{.Predicate}}:
        m2 := &TL{{.Name}}{Data2: &{{.ResType}}_Data{}}
        m2.Decode(dbuf)
        m.Data2 = m2.Data2
{{end}}
    default:
        return fmt.Errorf("Invalid constructorId: %d", int32(m.Constructor))
    }
    return dbuf.err
}

{{ range .SubMessageList }}// {{.Line}}
func (m *{{.ResType}}) To_{{.Name}}() *TL{{.Name}} {
    return &TL{{.Name}}{
        Data2: m.Data2,
    }
}

{{end}}

{{ range $i, $v := .SubMessageList }}// {{.Line}}
func (m *TL{{.Name}}) To_{{.ResType}}() *{{.ResType}} {
    return &{{.ResType}}{
        Constructor: TLConstructor_CRC32_{{.Predicate}},
        Data2: m.Data2,
    }
}

{{range $i2, $v2 := .ParamList}}
func (m *TL{{$v.Name}}) Set{{.Name}}(v {{.Type}}) { m.Data2.{{.Name2}} = v }
func (m *TL{{$v.Name}}) Get{{.Name}}() {{.Type}} { return m.Data2.{{.Name2}} }
{{end}}

func NewTL{{.Name}}() *TL{{.Name}} {
    return &TL{{.Name}}{ Data2: &{{.ResType}}_Data{} }
}

func (m *TL{{.Name}}) Encode() []byte {
    x := NewEncodeBuf(512)
    x.Int(int32(TLConstructor_CRC32_{{.Predicate}}))

{{range $i2, $v2 :=    .EncodeCodeList}}    {{$v2}}
{{end}}
    return x.buf
}


func (m *TL{{.Name}}) EncodeToLayer(layer int) []byte {
    x := NewEncodeBuf(512)
    x.Int(int32(TLConstructor_CRC32_{{.Predicate}}))

{{range $i2, $v2 :=    .EncodeCodeList}}    {{$v2}}
{{end}}
    return x.buf
}

func (m *TL{{.Name}}) Decode(dbuf *DecodeBuf) error {
{{range $i2, $v2 :=    .DecodeCodeList}}    {{$v2}}
{{end}}
    return dbuf.err
}
{{end}}
{{end}}

{{range .RequestList}}
func NewTL{{.Name}}() * TL{{.Name}} {
    return &TL{{.Name}}{}
}

func (m *TL{{.Name}}) Encode() []byte {
x := NewEncodeBuf(512)
x.Int(int32(TLConstructor_CRC32_{{.Predicate}}))

{{range $i2, $v2 :=    .EncodeCodeList}}    {{$v2}}
{{end}}
return x.buf
}

func (m *TL{{.Name}}) EncodeToLayer(layer int) []byte {
x := NewEncodeBuf(512)
x.Int(int32(TLConstructor_CRC32_{{.Predicate}}))

{{range $i2, $v2 :=    .EncodeCodeListLayer}}    {{$v2}}
{{end}}
return x.buf
}

func (m *TL{{.Name}}) Decode(dbuf *DecodeBuf) error {
{{range $i2, $v2 :=    .DecodeCodeList}}    {{$v2}}
{{end}}
return dbuf.err
}
{{end}}