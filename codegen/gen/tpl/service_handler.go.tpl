package rpc

import (
    "github.com/golang/glog"
    "github.com/nebulaim/telegramd/mtproto"
    "golang.org/x/net/context"
    "fmt"
    "github.com/nebulaim/telegramd/grpc_util"
    "github.com/nebulaim/telegramd/baselib/logger"
)

// {{.Line}}
func (s *{{.RPCName}}ServiceImpl) {{.RequestName}}(ctx context.Context, request *mtproto.TL{{.RequestName}}) (*mtproto.{{.ResponseName}}, error) {
    md := grpc_util.RpcMetadataFromIncoming(ctx)
    glog.Infof("{{.RequestName}} - metadata: %s, request: %s", logger.JsonDebugData(md), logger.JsonDebugData(request))

    // TODO: Impl {{.RequestName}} logic

    return nil, fmt.Errorf("Not impl {{.RequestName}}")
}
