from flask import Flask, request, jsonify
import pandas as pd
import plotly.graph_objs as go
import plotly.express as px
import json

app = Flask(__name__)

# In-memory data storage for demonstration
editor_data = []
arc_lake_data = pd.DataFrame(columns=['Arc Lake'])

@app.route('/append_data', methods=['POST'])
def append_data():
    global editor_data, arc_lake_data
    data = request.json
    sheet_name = data['sheetName']
    content = data['data']

    if sheet_name == 'AuroraScript':
        editor_data.append(content)
    elif sheet_name == 'Arc Lake':
        arc_lake_data = arc_lake_data.append({'Arc Lake': content}, ignore_index=True)

    return jsonify(result='success')

@app.route('/get_editor_plot', methods=['GET'])
def get_editor_plot():
    fig = create_3d_wave_plot(editor_data, 'Editor Data')
    return json.dumps(fig, cls=plotly.utils.PlotlyJSONEncoder)

@app.route('/get_arc_lake_plot', methods=['GET'])
def get_arc_lake_plot():
    fig = create_3d_wave_plot(arc_lake_data['Arc Lake'].values.tolist(), 'Arc Lake Data')
    return json.dumps(fig, cls=plotly.utils.PlotlyJSONEncoder)

@app.route('/get_combined_plot', methods=['GET'])
def get_combined_plot():
    combined_data = editor_data + arc_lake_data['Arc Lake'].values.tolist()
    fig = create_3d_bar_plot(combined_data, 'Combined Data')
    return json.dumps(fig, cls=plotly.utils.PlotlyJSONEncoder)

def create_3d_wave_plot(data, title):
    z_data = [data[i:i+5] for i in range(0, len(data), 5)]  # Convert to 2D array
    fig = go.Figure(data=[go.Surface(z=z_data)])
    fig.update_layout(title=title, autosize=False, width=400, height=400)
    return fig

def create_3d_bar_plot(data, title):
    fig = px.bar_3d(x=list(range(len(data))), y=[0]*len(data), z=data, title=title)
    fig.update_layout(autosize=False, width=400, height=400)
    return fig

if __name__ == '__main__':
    app.run(debug=True)