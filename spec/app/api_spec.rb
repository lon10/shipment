describe 'API' do
  it 'should greet us' do
    get '/api/'

    expect(last_response).to be_ok
    expect(last_response.body).to eq(%Q{"Welcome to Shipment"})
  end

  describe 'Delivery' do
    subject {
      last_response
    }

    context 'with incorrect params' do
      before do
        post '/api/delivery'
      end

      it { expect(subject.status).to eq(400) }
      it { expect(subject.body).to eq({ error: 'region is missing, items is missing' }.to_json) }
    end

    context 'with only one supplier' do
      let(:params) do
        {
          region: 'us',
          items: [
            { title: 'black_mug', count: '2' },
            { title: 'pink_t-shirt', count: '1' }
          ]
        }
      end

      let(:expected_result) do
        {
          'delivery_date' => '05-09-2020', 
          'shipments' => [
            {
              'supplier' => 'Shirts4U', 
              'delivery_date' => '05-09-2020', 
              'items' => [
                {
                  'title' => 'black_mug',
                  'count' => 2
                },
                {
                  'title' => 'pink_t-shirt',
                  'count' => 1
                }
              ]
            }
          ]
        }
      end

      before do
        post '/api/delivery', params
      end

      it { expect(subject.status).to eq(201) }
      it { expect(subject.body).to eq(expected_result.to_json) }
    end

    context 'with multiple one supplier' do
      let(:params) do
        {
          region: 'us',
          items: [
            { title: 'black_mug', count: '6' },
            { title: 'pink_t-shirt', count: '1' }
          ]
        }
      end

      let(:expected_result) do
        {
          'delivery_date' => '05-09-2020', 
          'shipments' => [
            { 'supplier'=>'Shirts4U', 'delivery_date'=>'05-09-2020', 'items'=>[{'title'=>'black_mug', 'count'=>3}] },
            { 'supplier'=>'Shirts Unlimited', 'delivery_date'=>'05-09-2020', 'items'=>[{'title'=>'black_mug', 'count'=>3}] },
            { 'supplier'=>'Best Tshirts', 'delivery_date'=>'05-09-2020', 'items'=>[{'title'=>'pink_t-shirt', 'count'=>1}] }
          ]
        }
      end

      before do
        post '/api/delivery', params
      end

      it { expect(subject.status).to eq(201) }
      it { expect(subject.body).to eq(expected_result.to_json) }
    end

  end
end