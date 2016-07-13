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
        if ( this.state.n == 0 ) {
            return (
                <span>
                    <div className="form-group" >
                        <a onClick={this.increaseHeaders} className="addheader">
                            Add a custom header
                        </a>
                    </div>
                </span>
            )
        } else {
            return (
                <span>
                    {_.times(this.state.n, i =>
                        <div className="row" key={i}>
                            <div className="col-md-5">
                                <div className="form-group">
                                    <input className="form-control" type="text" name="mock[customheaders][][name]" placeholder="Header name ..."/>
                                </div>
                            </div>
                            <div className="col-md-7">
                                <div className="form-group">
                                    <input className="form-control" type="text" name="mock[customheaders][][value]" placeholder="Value ..."/>
                                </div>
                            </div>
                        </div>
                    )}
                    <div className="form-group" >
                        <a onClick={this.increaseHeaders} className="addheader">
                            Add another header
                        </a>
                    </div>
                </span>
            )
        }
    }
});