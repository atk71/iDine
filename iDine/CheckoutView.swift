//
//  CheckoutView.swift
//  iDine
//
//  Created by Andrew Kuttichira on 11/22/21.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
	@State private var tipAmount = 15
	@State private var showingPaymentAlert = false
    
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    let tipAmounts = [10, 15, 20, 25, 0]
	
    var body: some View {
        Form {
            Section {
                Picker("How would you like to make your payment?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
            }
			
            Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
            
            if addLoyaltyDetails {
				TextField("Enter your iDine ID", text: $loyaltyNumber)
            }
			
			Section(header: Text("Add a tip?")) {
				Picker("Percentage:", selection: $tipAmount) {
					ForEach(tipAmounts, id: \.self) {
						Text("\($0)%")
					}
				}
				.pickerStyle(SegmentedPickerStyle())
			}
			
			Section(header:
				Text("TOTAL: \(totalPrice)")
					.font(.largeTitle)
			) {
				Button("Confirm Order") {
					showingPaymentAlert.toggle()
				}
			}
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
		.alert(isPresented: $showingPaymentAlert) {
			Alert(title: Text("Order Confirmed"), message: Text("Your total was \(totalPrice) - Thank you!"), dismissButton: .default(Text("OK")))
		}
    }
	
	var totalPrice: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		
		let total = Double(order.total)
		let tipValue = total / 100 * Double(tipAmount)
		
		return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
	}
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView().environmentObject(Order())
    }
}
