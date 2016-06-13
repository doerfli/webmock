var MRContent = React.createClass({
    render: function() {
        return (
            <div className="content">
                <div className="panel panel-default">
                    <div className="panel-heading">
                        <h3 className="panel-title">General request information</h3>
                    </div>
                    <div className="general panel-body">
                        <div className="table-striped">
                            <div className="row">
                                <div className="col-sm-4">
                                    Method
                                </div>
                                <div className="col-sm-8">
                                    { this.props.data.method }
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-sm-4">
                                    Original URL
                                </div>
                                <div className="col-sm-8">
                                    { this.props.data.url }
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-sm-4">
                                    Source IP
                                </div>
                                <div className="col-sm-8">
                                    { this.props.data.remote_address }
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-sm-4">
                                    Timestamp
                                </div>
                                <div className="col-sm-8">
                                    { this.props.data.created_at_date } { this.props.data.created_at_time }
                                </div>
                            </div>
                            {(() => {
                                if ( this.props.data.query_params_as_text != "" ) {
                                    return (
                                        <div className="row">
                                            <div className="col-sm-4">
                                                Query parameters
                                            </div>
                                            <div className="col-sm-8">
                                                { this.props.data.query_params_as_text.split("\n").map(function(item) {
                                                    return ( <span>{item} <br/></span> )
                                                }) }
                                            </div>
                                        </div>
                                    )
                                }
                            })()
                            }
                            <div className="row">
                                <div className="col-sm-4">
                                    Number of headers
                                </div>
                                <div className="col-sm-8">
                                    { Object.keys(this.props.data.headers).length }
                                </div>
                            </div>
                            <div className="row">
                                <div className="col-sm-4">
                                    Body size
                                </div>
                                <div className="col-sm-8">
                                    { this.props.data.body_size } Bytes
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="panel panel-default">
                    <div className="panel-heading">
                        <h3 className="panel-title">Headers</h3>
                    </div>
                    <div className="headers panel-body">
                        <div className="row">
                            <div className="col-sm-4">
                                CONTENT_TYPE
                            </div>
                            <div className="col-sm-8">
                                { this.props.data.contenttype }
                            </div>
                        </div>
                        {Object.keys(this.props.data.headers).map(function (key) {
                            var value = this.props.data.headers[key];
                            return (
                                <div className="row">
                                    <div className="col-sm-4 key">
                                        {key}
                                    </div>
                                    <div className="col-sm-8 value">
                                        {value}
                                    </div>
                                </div>
                            )
                        }.bind(this))}
                    </div>
                </div>
                <div className="panel panel-default">
                    <div className="panel-heading">
                        <h3 className="panel-title">
                            Body
                            {(() => {
                                if ( this.props.data.body != null && this.props.data.body.length > 0 ) {
                                    var url = "/mock_requests/" + this.props.data._id.$oid + "/raw_body";
                                    return (
                                        <small>( <a href={url} target="_blank">Show raw</a> )</small>
                                    )
                                }
                            })()}
                        </h3>
                    </div>
                    <div className="body panel-body">
                        {(() => {
                            if (this.props.data.body != null && this.props.data.body.length > 0 ) {
                                return (
                                    <pre>
                                        {this.props.data.body}
                                    </pre>
                                )
                            } else {
                                return (
                                    <div className="bodyempty">
                                        Request contained no body data
                                    </div>
                                )
                            }
                        })()}
                    </div>
                </div>
            </div>
        )
    }
});