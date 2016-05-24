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
    handleRequestClick: function(event, i) {
        this.setState({current: this.state.requests[i]});
    },
    handleRefreshClick: function(event) {
        $.ajax({
            url: "/mocks/" + this.props.mockid + "/history.json",
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState({requests: data, current: data[0]});
            }.bind(this)
        });
    },
    render: function() {
        return (
            <div className="history">
                <div className="row">
                    <div className="col-md-2 timeline_outer">
                        <h3 className="panel-title">Requests</h3>
                        <button type="button" className="btn btn-default refresh" onClick={this.handleRefreshClick}>Refresh</button>
                        <MRTimeline data={this.state.requests} onTimelineItemClick={this.handleRequestClick}/>
                    </div>
                    <div className="col-md-10">
                        <div className="panel panel-default">
                            <div className="panel-heading">
                                <h3 className="panel-title">Request content</h3>
                            </div>
                            <div className="panel-body">
                                <MRContent data={this.state.current}/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
});

