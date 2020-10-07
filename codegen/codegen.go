package main

import (
	"flag"
	//	"fmt"
	"github.com/magicsong/color-glog"
	gengolang "mtprotoc/codegen/gen/golang"
	"mtprotoc/codegen/gen/proto"
	mtproto_parser "mtprotoc/codegen/parser"
	"os"
)

func init() {
	flag.Set("alsologtostderr", "true")
	flag.Set("log_dir", "false")
}

func main() {
	flag.Parse()
	if _, err := os.Stat("out"); os.IsNotExist(err) {
		err := os.Mkdir("out", 0755)
		if err != nil {
			glog.Fatal("critical error", err)
		}
	}
	if _, err := os.Stat("out/rpc"); os.IsNotExist(err) {
		err := os.Mkdir("out/rpc", 0755)
		if err != nil {
			glog.Fatal("critical error", err)
		}
	}
	schemas, err := mtproto_parser.Parse("./schemas/scheme.tl")
	if err != nil {
		glog.Fatal(err)
	}
	genproto.GenProto(schemas, "./")
	gengolang.GenGolang(schemas, "./")
	glog.Info("Done")
}
