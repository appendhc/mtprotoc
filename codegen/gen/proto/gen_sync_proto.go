package genproto

import (
	"bytes"
	"fmt"
	"github.com/magicsong/color-glog"
	"io/ioutil"
	mtproto_parser "mtprotoc/codegen/parser"
	"text/template"
)

func genSyncProto(schemas *mtproto_parser.MTProtoSchemas, outFilePath string) {
	baseTypes := makeBaseTypeListTpl(schemas.Sync, false)
	var buf bytes.Buffer
	t := template.Must(template.ParseFiles("./gen/tpl/schema.tl.sync.proto.tpl"))
	t.Execute(&buf, baseTypes)
	err := ioutil.WriteFile(fmt.Sprintf("%s/out/schema.tl.sync.proto", outFilePath), buf.Bytes(), 0666)
	if err != nil {
		glog.Fatal("genCoreTypesProto error: ", err)
	}

	funcs := makeFunctionDataListTpl(schemas.Sync)
	// messages := &TplMessages{}
	// messages.FunctionList = makeTplFunctions(schemas.Sync)
	// messages.RPCList = makeRpcFunctions(schemas.Sync)
	var buf2 bytes.Buffer
	t = template.Must(template.ParseFiles("./gen/tpl/schema.tl.sync_service.proto.tpl"))
	t.Execute(&buf2, funcs)
	err = ioutil.WriteFile(fmt.Sprintf("%s/out/schema.tl.sync_service.proto", outFilePath), buf2.Bytes(), 0666)
	if err != nil {
		glog.Fatal("genCoreTypesProto error: ", err)
	}

}
