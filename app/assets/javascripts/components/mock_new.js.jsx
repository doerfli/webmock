class MockNew extends React.Component {

    constructor(props) {
        super(props);
        this.state = {
            new_mock: this.props.new_mock
        };
    }

    // TODO use i18n-js
    // TODO use state

    render() {
        return (
            <div className="container">
                <div className="panel panel-default">
                    <div className="panel-heading">
                        <h3 className="panel-title">Create your HTTP service mock right here and now</h3>
                    </div>
                    <div className="panel-body new_mock">
                        <div className="row">
                            <div className="col-md-10">
                                <div className="form-group">
                                    Body
                                    <textarea className="form-control" cols="50" rows="10"
                                              defaultValue={this.state.new_mock.body} id="mock_body"/>
                                </div>

                                <AdvancedConfig new_mock={this.props.new_mock}/>

                                {/* TODO recaptcha

                                 <% if session[:to_be_verified] %>
                                 <%= recaptcha_tags %>
                                 <% end %>

                                 */}

                                <div>
                                    <input type="submit" value="Create mock now!" className="btn btn-primary"/>
                                    <a className="btn btn-default" href="/">Reset</a>
                                </div>

                            </div>

                            <div className="col-md-2">
                                <div className="form-group">
                                    <label htmlFor="mock_statuscode">Status Code</label>:
                                    <input className="form-control" type="text"
                                           defaultValue={this.state.new_mock.statuscode || '200' }/>
                                </div>

                                <div className="form-group">
                                    <label htmlFor="mock_contenttype">Contenttype</label>:
                                    <select className="form-control ta_ct"
                                            defaultValue={this.state.new_mock.contenttype || 'application/json'} >
                                        {this.props.mime_types.map(function(typ,i) {
                                            var k = 'k' + i;
                                            return <option key={k}>{typ}</option>;
                                        }.bind(this))}
                                    </select>
                                </div>

                                <div className="form-group">
                                    {/* TODO use CSS instead of style */}
                                    {/* TODO make filedrag work inside react component */}
                                    <input type="file"  id="mock_fileselect" style={{display: 'none'}}/>
                                    <div id="filedrag" className="form-control" style={{display: 'inline-block'}}>
                                        <i className="fa fa-cloud-upload"/>&nbsp;&nbsp;&nbsp;Drop a file here to upload content
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        )
    }
}
