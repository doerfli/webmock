var MRHistory = React.createClass({
    getInitialState: function() {
        return {
            requests: this.props.data,
            current: this.props.data.length > 0 ? this.props.data[0] : {}
        };
    },
    getDefaultProps: function() {
        return {
            requests: [],
            current: {}
        };
    },
    render: function() {
        return (
            <div className="history">
                <h2>History</h2>
                <div className="row">
                    <div className="col-md-2">
                        <h3>Timeline</h3>
                        <MRTimeline data={this.state.requests}/>
                    </div>
                    <div className="col-md-8">
                        <h3>Request content</h3>
                        <MRContent data={this.state.current}/>
                    </div>
                </div>
            </div>
        )
    }
});

