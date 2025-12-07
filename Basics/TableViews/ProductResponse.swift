//
//  ProductResponse.swift
//  UIKitTutorial
//
//  Created by ikhwan on 07/12/25.
//


import UIKit

// MARK: - Data Models (What our JSON looks like)
struct ProductResponse: Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let category: String
    let price: Double
    let thumbnail: String
}

// MARK: - Product List View Controller
class ProductListViewController: UIViewController {
    
    // Our data array (starts empty)
    var products: [Product] = []
    
    // The table view
    let tableView = UITableView()
    
    // Loading indicator (spinner)
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products"
        view.backgroundColor = .white
        
        setupTableView()
        setupActivityIndicator()
        fetchProducts() // Go get the data!
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
    
    func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // STEP 1: Fetch data from API
    func fetchProducts() {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            print("Invalid URL")
            return
        }
        
        // Create the request
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Handle errors
            if let error = error {
                print("Error fetching products: \(error)")
                return
            }
            
            // Make sure we have data
            guard let data = data else {
                print("No data received")
                return
            }
            
            // STEP 2: Parse the JSON
            do {
                let decoder = JSONDecoder()
                let productResponse = try decoder.decode(ProductResponse.self, from: data)
                
                // STEP 3: Update UI on main thread (IMPORTANT!)
                DispatchQueue.main.async {
                    self?.products = productResponse.products
                    self?.tableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume() // Start the network request
    }
}

// MARK: - UITableViewDataSource
extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get the selected product
        let product = products[indexPath.row]
        
        // Navigate to detail view
        let detailVC = ProductDetailViewController(product: product)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Custom Table View Cell
class ProductCell: UITableViewCell {
    
    let productImageView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        // Image
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 8
        productImageView.backgroundColor = .systemGray5
        contentView.addSubview(productImageView)
        
        // Title
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)
        
        // Category
        categoryLabel.font = .systemFont(ofSize: 13)
        categoryLabel.textColor = .systemGray
        contentView.addSubview(categoryLabel)
        
        // Price
        priceLabel.font = .boldSystemFont(ofSize: 15)
        priceLabel.textColor = .systemGreen
        contentView.addSubview(priceLabel)
        
        // Layout (simple frame-based)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Image on left
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 70),
            productImageView.heightAnchor.constraint(equalToConstant: 70),
            
            // Title
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Category
            categoryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            // Price
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        categoryLabel.text = product.category.uppercased()
        priceLabel.text = "$\(String(format: "%.2f", product.price))"
        
        // Load image from URL
        loadImage(from: product.thumbnail)
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // Simple image loading (in real apps, use a library like SDWebImage or Kingfisher)
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.productImageView.image = image
            }
        }.resume()
    }
}

// MARK: - Product Detail View Controller
class ProductDetailViewController: UIViewController {
    
    let product: Product
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let priceLabel = UILabel()
    let idLabel = UILabel()
    
    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Product Details"
        
        setupViews()
        displayProduct()
    }
    
    func setupViews() {
        // Image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        view.addSubview(imageView)
        
        // Title
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        // Category
        categoryLabel.font = .systemFont(ofSize: 16)
        categoryLabel.textColor = .systemGray
        categoryLabel.textAlignment = .center
        view.addSubview(categoryLabel)
        
        // Price
        priceLabel.font = .boldSystemFont(ofSize: 28)
        priceLabel.textColor = .systemGreen
        priceLabel.textAlignment = .center
        view.addSubview(priceLabel)
        
        // ID
        idLabel.font = .systemFont(ofSize: 14)
        idLabel.textColor = .systemGray2
        idLabel.textAlignment = .center
        view.addSubview(idLabel)
        
        // Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            categoryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 16),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            idLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            idLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func displayProduct() {
        titleLabel.text = product.title
        categoryLabel.text = "Category: \(product.category)"
        priceLabel.text = "$\(String(format: "%.2f", product.price))"
        idLabel.text = "Product ID: #\(product.id)"
        
        // Load image
        if let url = URL(string: product.thumbnail) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }.resume()
        }
    }
}