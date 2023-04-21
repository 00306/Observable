//
//  PrefaceView.swift
//  wwdcssc
//
//  Created by Song Jihyuk on 2023/04/14.
//

import SwiftUI

struct PrefaceView: View {
    @State private var first = true
    @State private var second = false
    @State private var third = false
    @State private var last = false
    
    var images = ["Low_Earth_Orbit", "starLinkAspectofHubble", "starLinkAspectOfObservatory", "Indifference"]
    
    var title = ["Low Earth Orbit", "Hubble Space Telescope", "Observatories", "Interest"]
    var description = ["With recent advancements in the space industry, the number of privately-owned low-earth orbit satellites has rapidly increased.\nAs a result, bright and numerous satellites have been obstructing the view of astronomical telescopes and causing issues for celestial observations.",
                       
                       "This image is taken by the Hubble Space Telescope, and the streaks seen in front of numerous stars are traces of artificial satellites passing by during the telescope's exposure. As the number of artificial satellites increases, the proportion of such obstructed images used for research is also increasing. The concerning issue is that with the consideration of the upcoming satellites planned by companies, Despite its ability to continue its mission for a long time yet, the Hubble Space Telescope will soon face a situation where its mission will become impossible to carry out within a few years.",
                       
                       "Observatories face the same situation as the Hubble Space Telescope. They are constantly disrupted by the vast number of bright satellites, interfering with observatories ability to take photographs. While it is possible for future space telescopes to be installed in orbits that are less obstructed, observatories on the Earth's surface are fully exposed to the increasing impact of satellites being launched without solution.",
                       
                       "The crucial issue is that it's difficult for ordinary people to feel the impact of the problem. Just because the view of a telescope is obstructed doesn't mean people will directly feel the effects on their lives. Some people cannot empathize with the need for astronomical time and resources to address the problem, and as a result, they may not be deeply committed to the industry. Without experiencing it firsthand, people may not realize the significance of the issue and may not fully engage with finding a solution."]
    
    @Binding var preface: Bool
    @State private var currentIndex = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    GeometryReader {
                        let imageSize = $0.size
                        VStack {
                            Text("Astronomy's Challenges")
                                .font(.system(size: 50, weight: .black))
                                .foregroundColor(Color("e6e6e6"))
                                .padding()
                    
                            VStack(alignment: .center) {
                                
                                HStack(spacing: 5) {
                                    Spacer()
                                    
                                    Image(systemName: "lessthan")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing)
                                        .onTapGesture {
                                            if currentIndex <= 0 {
                                                withAnimation(.linear(duration: 0.2)) {
                                                    currentIndex = 3
                                                }
                                                
                                                withAnimation(.linear(duration: 0.2)) {
                                                    switch currentIndex {
                                                    case 1:
                                                        second = true
                                                    case 2:
                                                        third = true
                                                    case 3:
                                                        last = true
                                                        
                                                    default:
                                                        first = true
                                                    }
                                                }
                                                
                                            } else {
                                                withAnimation(.linear(duration: 0.2)) {
                                                    currentIndex -= 1
                                                }
                                                
                                                withAnimation(.linear(duration: 0.2)) {
                                                    switch currentIndex {
                                                    case 1:
                                                        second = true
                                                    case 2:
                                                        third = true
                                                    case 3:
                                                        last = true
                                                        
                                                    default:
                                                        first = true
                                                    }
                                                }
                                            }
                                        }
                                    
                                    Image(images[currentIndex])
                                        .resizable()
                                        .frame(width: imageSize.width / 4.5)
                                        .cornerRadius(16)
                                    
                                    Image(systemName: "greaterthan")
                                        .resizable()
                                        .foregroundColor(.gray)
                                        .frame(width: 20, height: 20)
                                        .padding(.leading)
                                        .onTapGesture {
                                            if currentIndex >= 3 {
                                                withAnimation(.linear(duration: 0.2)) {
                                                    currentIndex = 0
                                                }
                                                withAnimation(.linear(duration: 0.2)) {
                                                    switch currentIndex {
                                                    case 1:
                                                        second = true
                                                    case 2:
                                                        third = true
                                                    case 3:
                                                        last = true
                                                        
                                                    default:
                                                        first = true
                                                    }
                                                }
                                            } else {
                                                withAnimation(.linear(duration: 0.2)) {
                                                    currentIndex += 1
                                                }
                                                
                                                withAnimation(.linear(duration: 0.2)) {
                                                    switch currentIndex {
                                                    case 1:
                                                        second = true
                                                    case 2:
                                                        third = true
                                                    case 3:
                                                        last = true
                                                        
                                                    default:
                                                        first = true
                                                    }
                                                }
                                            }
                                        }
                                    
                                    Spacer()
                                }
                                
                                
                                VStack {
                                    Text(title[currentIndex])
                                        .font(.system(size: 18, weight: .black, design: .rounded))
                                        .padding(.bottom)
                                    
                                    Text(description[currentIndex])
                                        .font(.system(size: 15, weight: .medium, design: .rounded))
                                        .frame(width: imageSize.width / 1.3)
                                    
                                    Spacer()
                                }
                                            
                                    
                                    

                            }
                            
                            
                            
                            VStack {
                                
                                HStack {
                                    Spacer()
                                    
                                    Button {
                                        withAnimation(.interactiveSpring(response: 3, dampingFraction: 0.8, blendDuration: 0.2)) {
                                            self.preface.toggle()
                                        }
                                    } label: {
                                        Text("I Understand!")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .black, design: .rounded))
                                            .padding(.vertical, 10)
                                            .padding(.horizontal)
                                            .background {
                                                Capsule()
                                                    .fill(.blue)
                                            }
                                    }
                                    .padding()
                                    
                                    Spacer()
                                }
                        }
                            .opacity(first && second && third && last ? 1 : 0)
                            
                            
                        }
                        
                        
                        
                    }
                    .frame(width: size.width / 1.5, height: size.height / 1.5)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.bar)
                    }
                 
                    Spacer()
                }
                Spacer()
            }
            
        }
    }
}
