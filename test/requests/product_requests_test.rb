require 'test_helper'

class ProductRequestsTest < ActionDispatch::IntegrationTest
  
  test 'GET /products' do
    products = create_list(:product, 3)
    get '/products'
    assert_response :ok
    json_body = JSON(@response.body)
    assert_equal 3, json_body.count
    assert_equal 'Coma', json_body.first['name']
    assert_equal 'Coma description 1', json_body.first['description']
    assert_equal 15.99, json_body.first['price']
    assert_equal 3, json_body.first['quantity']
    #assert_equal products.to_json, @response.body
  end

  test 'POST /products' do
    post '/products', params: {product: attributes_for(:product)}
    assert_equal 1, Product.count
    assert_response :created
    assert_equal Product.first.to_json, @response.body
  end

  test 'POST /products with invalid data' do
    post '/products', params: {product: attributes_for(:product, name: nil)}
    assert_equal 0, Product.count
    assert_response 422
    assert_includes JSON.parse(@response.body)["errors"]["name"], "can't be blank"
  end

  test 'GET /products/:id' do
    product = create(:product)
    get "/products/#{product.id}"
    assert_response :ok
    assert_equal product.to_json, @response.body
  end

  test 'GET /products/:id with invalid id' do
    get "/products/1"
    assert_response :not_found
    assert_includes @response.body, "Couldn't find Product with 'id'=1" 
  end

  test 'PUT /products/:id' do
    product = create(:product)
    put "/products/#{product.id}", params: { product: { price: 115 }  }
    assert_response :ok
    assert_equal 115, Product.first.price
  end

  test 'PUT /products/:id with invalid params' do
    product = create(:product)
    put "/products/#{product.id}", params: { product: { price: -115 }  }
    assert_response 422
    assert_includes JSON.parse(@response.body)["errors"]["price"], 'must be greater than or equal to 0.0'
  end

  test 'DELETE /products/:id' do
    product = create(:product)
    delete "/products/#{product.id}"
    assert_response :ok
    assert_equal 0, Product.count
  end

end
