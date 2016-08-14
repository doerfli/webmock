var AdvancedConfig = React.createClass({
    getInitialState: function() {
        return {
            new_mock: this.props.new_mock,
            enabled: this.props.new_mock.created_at != null,
            numHeaders: this.props.new_mock.created_at == null || this.props.new_mock.customheaders == null ? 0 : this.props.new_mock.customheaders.length,
        };
    },
    getDefaultProps: function() {
        return {
            enabled: false,
            numHeaders: 0
        };
    },
    enableAdvanced: function() {
        this.setState({enabled: true, numHeaders: this.state.numHeaders + 1});
    },
    increaseHeaders: function() {
        this.setState({numHeaders: this.state.numHeaders + 1});
    },
    render: function() {
        if ( ! this.state.enabled ) {
            return (
                <span>
                    <div className="form-group" >
                        <a onClick={this.enableAdvanced} className="link">
                            Enable advanced configuration
                        </a>
                    </div>
                </span>
            )
        } else {
            return (
                <span>
                    <h4>Advanced configuration</h4>
                    <div className="row">
                        <div className="col-md-6">
                            <div className="form-group">
                                <label>Charset</label>
                                <input className="form-control"
                                       type="text"
                                       name="mock[charset]"
                                       defaultValue={this.state.new_mock.charset || 'UTF-8'} />
                            </div>
                        </div>
                        <div className="col-md-6">
                            <div className="form-group">
                                <label>Delay (seconds)</label>
                                <input className="form-control"
                                       type="number"
                                       name="mock[delay]"
                                       defaultValue={this.state.new_mock.delay || '0'}/>
                            </div>
                        </div>
                    </div>
                    <label>Custom headers</label>
                    {_.times(this.state.numHeaders, i =>
                        <div className="row" key={i}>
                            <div className="col-md-5">
                                <div className="form-group">
                                    <input className="form-control"
                                           type="text"
                                           name="mock[customheaders][][name]"
                                           placeholder="Header name ..."
                                           defaultValue={this.state.new_mock.customheaders && this.state.new_mock.customheaders[i].name || ''}/>
                                </div>
                            </div>
                            <div className="col-md-7">
                                <div className="form-group">
                                    <input className="form-control"
                                           type="text"
                                           name="mock[customheaders][][value]"
                                           placeholder="Value ..."
                                           defaultValue={this.state.new_mock.customheaders && this.state.new_mock.customheaders[i].value || ''}/>
                                </div>
                            </div>
                        </div>
                    )}
                    <div className="form-group" >
                        <a onClick={this.increaseHeaders} className="link">
                            Add another header
                        </a>
                    </div>
                </span>
            )
        }
    }
});