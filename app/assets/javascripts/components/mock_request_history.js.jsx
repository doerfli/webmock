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
        if ( this.state.requests.length == 0) {
            return (
                <div className="history">
                    <div className="row">
                        <div className="col-md-2 timeline_outer">
                            <h3 className="panel-title">Requests</h3>
                            <button type="button" className="btn  btn-info refresh" onClick={this.handleRefreshClick}>Refresh</button>
                            <div className="timeline">
                                <div className="request">
                                    <i>No requests received yet</i>
                                </div>
                            </div>
                        </div>
                        <div className="col-md-10">

                        </div>
                    </div>
                </div>
            )
        } else {
            return (
                <div className="history">
                    <div className="row">
                        <div className="col-md-2 timeline_outer">
                            <h3 className="panel-title">Requests</h3>
                            <button type="button" className="btn btn-info refresh" onClick={this.handleRefreshClick}>Refresh</button>
                            <MRTimeline data={this.state.requests} selectedId={this.state.current._id.$oid} onTimelineItemClick={this.handleRequestClick}/>
                        </div>
                        <div className="col-md-10">
                            <MRContent data={this.state.current}/>
                        </div>
                    </div>
                </div>
            )
        }

    }
});

