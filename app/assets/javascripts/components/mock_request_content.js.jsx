var MRContent = React.createClass({
    render: function() {
        return (
            <div className="content">
                <h4>General request information</h4>
                <div className="general table-striped">
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
                </div>
                <h4>Headers</h4>
                <div className="headers">
                    {Object.keys(this.props.data.headers).map(function (key) {
                        var value =  this.props.data.headers[key];
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
        )
    }
});