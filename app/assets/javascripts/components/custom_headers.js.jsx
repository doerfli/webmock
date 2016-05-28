var CustomHeaders = React.createClass({
    render: function() {
        return (
            <div className="row">
                <div className="col-md-4">
                    <div className="form-group">
                        <input className="form-control" type="text" name="mock[customheaders][][name]" placeholder="Header name ..."/>
                    </div>
                </div>
                <div className="col-md-6">
                    <div className="form-group">
                        <input className="form-control" type="text" name="mock[customheaders][][value]" placeholder="Value ..."/>
                    </div>
                </div>
                <div className="col-md-2">
                    &nbsp;
                </div>
            </div>
        )
    }
});