var CustomHeaders = React.createClass({
    getInitialState: function() {
        return {
            n: 0
        };
    },
    getDefaultProps: function() {
        return {
            n: 0
        };
    },
    increaseHeaders: function() {
        this.setState({n: this.state.n + 1});
    },
    render: function() {
        return (
            <span>
                {_.times(this.state.n, i =>
                    <div className="row" key={i}>
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
                )}
                <div className="row">
                    <div className="col-md-12">
                        <div className="form-group" >
                            <a onClick={this.increaseHeaders}>
                                Add another header
                            </a>
                        </div>
                    </div>
                </div>
            </span>
        )
    }
});