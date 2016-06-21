var MRHistory = React.createClass({
    getInitialState: function() {
        this.initializeWebsocket();
        return {
            requests: this.props.data,
            current: this.props.data.length > 0 ? this.props.data[0] : {}
        };
    },
    initializeWebsocket: function() {
        //console.log("Initializing websocket for mock "+ this.props.mockid);
        var comp = this;
        App.mockChannel = App.cable.subscriptions.create({channel: "MockChannel", id: this.props.mockid},
            {
                received: function(req) {
                    console.log(req);
                    comp.addNewRequest(req);
                }
            }
        );
    },
    addNewRequest: function(req) {
        var new_requests = this.state.requests;
        new_requests.unshift(req);
        if ( new_requests.length > 16 ) {
            new_requests.pop(); // remove last
        }
        this.setState({requests: new_requests});
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
    render: function() {
        if ( this.state.requests.length == 0) {
            return (
                <div className="history">
                    <div className="row">
                        <div className="col-md-2 timeline_outer">
                            <h3 className="panel-title">Requests</h3>

                            <div className="timeline">
                                <div className="request">
                                    <i>No requests received yet</i>
                                </div>
                            </div>

                            <div className="explanation">
                                <small>(This list will refresh automatically when a new request is received)</small>
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

                            <MRTimeline data={this.state.requests} selectedId={this.state.current._id.$oid} onTimelineItemClick={this.handleRequestClick}/>

                            <div className="explanation">
                                <small>(This list will refresh automatically when a new request is received)</small>
                            </div>
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

