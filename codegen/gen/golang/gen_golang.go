package gengolang

import (
	"bytes"
	"fmt"
	"github.com/magicsong/color-glog"
	"io/ioutil"
	mtproto_parser "mtprotoc/codegen/parser"
	"os"
	"text/template"
)

func genCodecSchema(schemas *mtproto_parser.MTProtoSchemas, outFilePath string) {
	codecs := &TplCodecDataList{}

	codecs.BaseTypeList = append(codecs.BaseTypeList, makeBaseTypeListTpl(schemas.Handshake)...)
	codecs.BaseTypeList = append(codecs.BaseTypeList, makeBaseTypeListTpl(schemas.Transport)...)
	codecs.BaseTypeList = append(codecs.BaseTypeList, makeBaseTypeListTpl(schemas.Sync)...)

	codecs.RequestList = append(codecs.RequestList, makeFunctionDataListTpl(schemas.Handshake)...)
	codecs.RequestList = append(codecs.RequestList, makeFunctionDataListTpl(schemas.Transport)...)
	codecs.RequestList = append(codecs.RequestList, makeFunctionDataListTpl(schemas.Sync)...)

	codecs.CRC32List = append(codecs.CRC32List, makeTplCRC32List(schemas.LayerCons)...)
	codecs.CRC32List = append(codecs.CRC32List, makeTplCRC32List(schemas.Handshake)...)
	codecs.CRC32List = append(codecs.CRC32List, makeTplCRC32List(schemas.Transport)...)
	codecs.CRC32List = append(codecs.CRC32List, makeTplCRC32List(schemas.Sync)...)

	//codecs.BaseTypeList = makeBaseTypeListTpl(schemas.Sync)
	//codecs.RequestList = makeFunctionDataListTpl(schemas.Sync)
	// glog.Info(baseTypes)

	var buf bytes.Buffer
	t := template.Must(template.ParseFiles("./gen/tpl/codec_schema.tl.pb.go.tpl"))
	t.Execute(&buf, codecs)
	err := ioutil.WriteFile(fmt.Sprintf("%s/codec_schema.tl.pb.go", outFilePath), buf.Bytes(), 0666)
	if err != nil {
		glog.Fatal("genCodecSchema error: ", err)
	}
}

func genRpcImpl(schemas *mtproto_parser.MTProtoSchemas, outFilePath string) {

	ignoreRpcList = []string{"invokeAfterMsg", "invokeAfterMsgs", "initConnection", "invokeWithLayer", "invokeWithoutUpdates"}
	serviceList := makeServiceDataListTpl(schemas.Sync)
	for k, vList := range serviceList {
		// glog.Info(baseTypes)

		for _, v := range vList {
			var buf bytes.Buffer
			t := template.Must(template.ParseFiles("./gen/tpl/service_impl.go.tpl"))
			t.Execute(&buf, v)
			if _, err := os.Stat(fmt.Sprintf("%s/out/rpc/%s/", outFilePath, k)); os.IsNotExist(err) {
				err := os.Mkdir(fmt.Sprintf("%s/out/rpc/%s", outFilePath, k), 0755)
				if err != nil {
					glog.Fatal("genRpcFold error: ", err)
				}
			}
			err := ioutil.WriteFile(fmt.Sprintf("%s/out/rpc/%s/%s_service_impl2.go", outFilePath, k, k), buf.Bytes(), 0666)
			if err != nil {
				glog.Fatal("genRpcImpl error: ", err)
			}
		}

		for _, v := range vList {
			var buf2 bytes.Buffer
			t2 := template.Must(template.ParseFiles("./gen/tpl/service_handler.go.tpl"))
			t2.Execute(&buf2, v)
			err := ioutil.WriteFile(fmt.Sprintf("%s/out/rpc/%s/%s_handler.go", outFilePath, k, v.MethodName), buf2.Bytes(), 0666)
			if err != nil {
				glog.Fatal("genRpcImpl error: ", err)
			}
		}
	}
}

func GenGolang(schemas *mtproto_parser.MTProtoSchemas, outFilePath string) {
	genCodecSchema(schemas, outFilePath)
	genRpcImpl(schemas, outFilePath)
}
