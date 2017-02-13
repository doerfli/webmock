class MRHistory extends React.Component {

    constructor(props) {
        super(props);
        this.initializeWebsocket();
        this.state = {
            requests: this.props.data,
            current: this.props.data.length > 0 ? this.props.data[0] : {}
        };
    }

    initializeWebsocket() {
        // console.log("Initializing websocket for mock "+ this.props.mockid);
        var comp = this;
        App.mockChannel = App.cable.subscriptions.create({channel: "MockChannel", id: this.props.mockid},
            {
                received: function(req) {
                    // console.log("received");
                    // console.log(req);
                    comp.addNewRequest(req);
                }
            }
        );
    }

    addNewRequest = (req) => {
        var new_requests = this.state.requests;
        new_requests.unshift(req);
        if ( new_requests.length > 50 ) {
            new_requests.pop(); // remove last
        }

        var c = this.state.current;

        if ( typeof c._id == 'undefined' ) {
            c = new_requests[0];
        }

        this.setState({requests: new_requests, current: c});
    }

    handleRequestClick = (event, i) => {
        console.log(this.state);
        this.setState({current: this.state.requests[i]});
    }

    render() {
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
}

// MRHistory.defaultProps = {
//     requests: [],
//     current: {}
// };

