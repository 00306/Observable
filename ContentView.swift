import SwiftUI
import RealityKit
import ARKit

enum CameraMode {
    case Telescope
    case Observatory
}

struct ContentView: View {
    @State private var take = false
    @State private var hubble = false
    @State private var observatory = false
    @State private var preface = true
    @State private var telescopeAR = false
    @State private var takeFinish = false
    @State private var url: URL?
    @State private var ray1 = false
    @State private var observatoryAR = false
    @State private var startObservatoryExperience = false
    @State private var bulb = false
    @State private var start = false
    @State private var observatoryTutorial = false
    @State private var startExposure = false
    @State private var main = true
    @State private var telescopeTutorialfirst = true
    @State private var telescopeTutorialSecond = false
    @State private var telescopeTutorialLast = false
    @State private var tutorialfirst = true
    @State private var observatoryFirst = false
    @State private var telescopeFirst = false
    @State private var dropFinger = false
    @State private var telescopeTutorial = false
    @State private var hubbleMode = false
    @State private var pullDevice = false
    
    var telescopeImages = ["Pillars of Creation", "Deepfield", "NGC_1300", "Crab_Nebula", "Earendel"]
    
    
    var body: some View {
        ZStack {
            if !observatory {
                MainView(take: $take, hubble: $hubble, observatory: $observatory, telescopeAR: $telescopeAR, hubbleMode: $hubbleMode, pullDevice: $pullDevice)
                    
            }
                            
            if preface {
                PrefaceView(preface: $preface)
                    .opacity(preface ? 1 : 0)
            } else {
                if hubble && !telescopeAR {
                    GeometryReader {
                        let size = $0.size
                        HStack {

                            Spacer()

                            RoundedRectangle(cornerRadius: 16)
                                .fill(.bar)
                                .overlay {
                                    VStack(alignment: .leading) {
                                        Text("Hubble Space Telescope")
                                            .font(.system(size: 36, weight: .black))
                                            .foregroundColor(Color("e6e6e6"))
                                            .padding()

                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(alignment: .bottom) {
                                                ForEach(0..<telescopeImages.count, id: \.self) { index in
                                                    Image(telescopeImages[index])
                                                        .resizable()
                                                        .frame(width: size.width / 4, height: size.height / 4)
                                                }
                                            }
                                            .padding()
                                        }
                                        
                                        Text("These photos showcase the incredible achievements of the Hubble Space Telescope from its launch in 1990 until the relatively recent year of 2022.\nLet's use AR to experience these amazing accomplishments of the Hubble Space Telescope at its current point in time.")
                                            .padding()
                                        
                                        Spacer()
                                        
                                        Button {
                                            withAnimation(.linear(duration: 0.5)) {
                                                telescopeAR.toggle()
                                                telescopeFirst = true
                                                telescopeTutorial = true
                                                hubbleMode = true
                                            }

                                        } label: {
                                            HStack {
                                                Spacer()

                                            HStack {
                                                Image(systemName: "arkit")
                                                Text("Experience with AR")

                                            }
                                            .font(.system(size: 16, weight: .black, design: .rounded))
                                            .foregroundColor(.white)
                                            .padding()
                                            .background {
                                                Capsule()
                                                    .fill(.blue)
                                            }

                                                Spacer()
                                        }
                                        }
                                        .padding(.bottom)
                                    }
                                }
                                .frame(width: size.width / 3, height: size.height)

                        }
                        
                    }
                    .opacity(observatory ? 0 : 1)

                }
                
                if telescopeAR {
                    GeometryReader {
                        let size = $0.size
    
                    ZStack {
                        HStack {
                            
                            Spacer()
                            
                            VStack {
                                Spacer()
                                
                                VStack(spacing: 20) {
                                    Image("Observatory_white")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15)
                                        .padding(15)
                                        .background {
                                            Circle()
                                                .fill(.bar)
                                        }
                                        .onTapGesture {
                                            if observatoryFirst {
                                                telescopeAR = false
                                                observatory = true
                                                startObservatoryExperience = true
                                                
                                            } else {
                                                observatory = true
                                            }
                                            
                                        }
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 50, height: 50)
                                        .scaleEffect(dropFinger ? 0.97 : 1)
                                        .background {
                                            Circle()
                                                .stroke(.white, lineWidth: 5)
                                                .frame(width: 60, height: 60)
                                        }
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 8)
                                        .onTapGesture {
                                            take = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                take = false
                                                
                                            }
                                        
                                        }
                                    
                                    Circle()
                                        .fill(.clear)
                                        .frame(width: 30, height: 30)
                                }
                                
                                Spacer()
                            }
                            .padding()
                            
                        }
                        VStack {
                            if telescopeTutorialfirst {
                                VStack {
                                    Image(systemName: "lines.measurement.horizontal")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: size.width / 3)
                                        .padding(.bottom, 30)
                                        
                                    Text("Find a comfortable place to stand")
                                        .font(.system(size: 20, weight: .black))
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.bar)
                                        .frame(width: size.width, height: size.height)
                                        .onTapGesture {
                                            withAnimation(.linear(duration: 0.5)) {
                                                telescopeTutorialfirst = false
                                                telescopeTutorialSecond = true
                                            }
                                            
                                        }
                                }
                                
                            } else if telescopeTutorialSecond {
                                VStack {
                                    Image(systemName: "ipad.landscape")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: size.width / 3)
                                        .padding(.bottom, 30)
                                    
                                    Text("Pull your device towards your body")
                                        .font(.system(size: 20, weight: .black))
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.bar)
                                        .frame(width: size.width, height: size.height)
                                        .onTapGesture {
                                            withAnimation(.linear(duration: 0.5)) {
                                                telescopeTutorialSecond = false
                                                telescopeTutorialLast = true
                                            }
                                            
                                        }
                                }
                            } else if telescopeTutorialLast {
                                Image("HubbleTelescope")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: size.width / 3)
                                    .padding(.bottom, 30)
                                
                                Text("Try taking a picture from inside the satellites!")
                                    .font(.system(size: 20, weight: .black))
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.bar)
                                .frame(width: size.width, height: size.height)
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        telescopeTutorial = false
                                        pullDevice = true
                                    }
                                    
                                }
                        }
                        .animation(.linear(duration: 0.5).delay(1.2), value: telescopeTutorial)
                        .opacity(telescopeTutorial ? 1 : 0)
                        
                    }
                    
                }
                }
                
                if main {
                    VStack {
                        Text("Observable")
                            .font(.system(size: 140, weight: .bold, design: .rounded))
                            .foregroundColor(Color("e6e6e6"))
                            .padding(.top, 32)
                        
                        HStack {
                        Button {
                            withAnimation(.interactiveSpring(response: 1.1, dampingFraction: 0.8, blendDuration: 0.8)) {
                                hubble.toggle()
                                main.toggle()
                                
                            }
                        } label: {
                            VStack {
                                
                                Image("HubbleTelescope")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150)
                                    .padding(.vertical)
                            
                                Text("Hubble Space Telescope")
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.bottom)
                            
                        }
                            .foregroundColor(Color("e6e6e6"))
                            .padding(.top)
                            .frame(width: 200, height: 200)

                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.bar)
                            }
                        }
                        .padding(.bottom)
                        
                        Button {
                            withAnimation(.interactiveSpring(response: 1.1, dampingFraction: 0.8, blendDuration: 0.8)) {
                                
                                observatory.toggle()
                                main.toggle()
                                DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 1.1) {
                                    hubble.toggle()
                                }
                            }
                        } label: {
                            VStack {

                                Image("Observatory")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150)
                                    .padding(.vertical)
                            
                                Text("Observatory")
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.bottom)
                            
                        }
                            .foregroundColor(Color("e6e6e6"))
                            .padding(.top)
                            .frame(width: 200, height: 200)
                            .background {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.bar)
                            }
                        }
                        .padding(.bottom)
                    }
                    }

                }
                
                if observatory && !startObservatoryExperience {
                    GeometryReader {
                        let size = $0.size

                          ObservatoryDescription()

                        HStack {
                            Spacer()

                            RoundedRectangle(cornerRadius: 16)
                                .fill(.bar)
                                .overlay {
                                    VStack(alignment: .leading) {
                                        Text("Observatory")
                                            .font(.system(size: 36, weight: .black))
                                            .foregroundColor(Color("e6e6e6"))
                                            .padding()
                                        
                                        Image("starLinkAspectOfObservatory")
                                            .resizable()
                                            .frame(width: size.width / 4, height: size.height / 4)
                                            .padding()
                                        

                                        Text("When taking a long exposure photograph at an observatory, long lines called 'Starlink trains' are visible in the sky. These are the paths of clusters of artificial satellites, which can interfere with astronomical observations by blocking stars or reflect sunlight while passing by, causing negative effects on celestial observations.\nAlthough some people intentionally seek out certain times to capture the beautiful shape, it is necessary to be cautious as the number of artificial satellites launched into space is expected to increase significantly in the coming years, potentially covering the sky more than it does now.\nLet's experience the Starlink train using AR.")
                                            .padding()
                                        
                                        Spacer()
                                        
                                        Button {
                                            withAnimation(.linear(duration: 0.5)) {
                                                startObservatoryExperience = true
                                                observatoryTutorial = true
                                                observatoryFirst = true
                                            }


                                        } label: {
                                            HStack {
                                                Spacer()

                                            HStack {
                                                Image(systemName: "arkit")
                                                Text("Experience with AR")
                                                    

                                            }
                                            .font(.system(size: 16, weight: .black, design: .rounded))
                                            .foregroundColor(.white)
                                            .padding()
                                            .background {
                                                Capsule()
                                                    .fill(.blue)
                                            }

                                                Spacer()
                                        }
                                        }
                                        .padding(.bottom)
                                    }
                                }
                                .frame(width: size.width / 3, height: size.height)

                        }
                    }
                }
               
               else if observatory && startObservatoryExperience {
                   GeometryReader {
                       let size = $0.size
                       
                       ZStack {
                       ObservatoryView(ray1: $ray1, observatoryAR: $observatoryAR, start: $start, observatory: $observatory, startObservatoryExperience: $startObservatoryExperience, startExposure: $startExposure)
                       
                       HStack {
                           Spacer()
                           
                           VStack(spacing: 20) {
                               Image("HubbleTelescope_white")
                                   .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 20)
                                   .padding(10)
                                   .background {
                                       Circle()
                                           .fill(.bar)
                                   }
                                   .onTapGesture {
                                       if telescopeFirst {
                                           telescopeAR = true
                                           observatory = false
                                       } else {
                                           telescopeAR = false
                                           observatory = false
                                       }
                                   }
                               
                               Circle()
                                   .fill(.white)
                                   .frame(width: 50, height: 50)
                                   .scaleEffect(dropFinger ? 0.97 : 1)
                                   .background {
                                       Circle()
                                           .stroke(.white, lineWidth: 5)
                                           .frame(width: 60, height: 60)
                                   }
                                   .padding(10)
                                   
                                   .gesture(
                                   DragGesture(minimumDistance: 0)
                                       .onChanged { _ in
                                           dropFinger = true
                                           
                                       }
                                       .onEnded { _ in
                                           dropFinger = false
                                           startExposure = true
                                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                               startExposure = false
                                           }
                                       })
                               
                               Circle()
                                   .fill(.clear)
                                   .frame(width: 30, height: 30)
                               
                           }
                       }
                       .padding()
                       
                       if observatoryTutorial {
                           
                               ZStack {
                                   
                                       ZStack {
                                           VStack {
                                                   Image(systemName: "ipad.landscape")
                                                       .resizable()
                                                       .aspectRatio(contentMode: .fit)
                                                       .frame(width: size.width / 3)
                                                       .foregroundColor(Color("e6e6e6"))
                                                       .padding(.bottom, 30)
                                               
                                               Text("Raise your device to the sky!")
                                                   .font(.system(size: 20, weight: .black))
                                               
                                           }
                                           .opacity(tutorialfirst ? 0 : 1)
                                           .offset(y: tutorialfirst ? 60 : 0)
                                           .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.8).delay(1.5), value: tutorialfirst)
                                       }
                                       .background {
                                           RoundedRectangle(cornerRadius: 16)
                                               .fill(.bar)
                                               .frame(width: size.width, height: size.height)
                                               .onTapGesture {
                                                   withAnimation(.linear(duration: 0.5)) {
                                                       observatoryTutorial = false
                                                       
                                                   }
                                                   
                                               }
                                           }
                                
                                       
                                       ZStack {
                                           HStack(alignment: .bottom, spacing: 60) {
                                               VStack {
                                                   ZStack {
                                                       Image(systemName: "lightbulb.fill")
                                                           .resizable()
                                                           .aspectRatio(contentMode: .fit)
                                                           .frame(width: size.width / 8)
                                                           .opacity(bulb ? 0 : 1)
                                                       
                                                           .foregroundColor(Color("e6e6e6"))
                                                       
                                                       Image(systemName: "lightbulb")
                                                           .resizable()
                                                           .aspectRatio(contentMode: .fit)
                                                           .frame(width: size.width / 8)
                                                           .foregroundColor(Color("e6e6e6"))
                                                           .opacity(bulb ? 1 : 0)
                                                       
                                                       
                                                   }
                                                   .padding(.bottom, 30)
                                                   .onAppear {
                                                       DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                                           withAnimation(.linear(duration: 0.5)) {
                                                               bulb.toggle()
                                                           }
                                                       }
                                                   }
                                                   .padding()
                                                   
                                                   Text("Turn off the light in your room")
                                                       .font(.system(size: 20, weight: .black))
                                                   
                                               }
                                               
                                               VStack {
                                                   ZStack {
                                                       Image(systemName: "moon.stars.fill")
                                                           .resizable()
                                                           .aspectRatio(contentMode: .fit)
                                                           .frame(width: size.width / 8)
                                                           .offset(y: bulb ? -30 : 0)
                                                           .foregroundColor(Color("e6e6e6"))
                                                       
                                                   }
                                                   .padding(.bottom, 30)
                                                   .padding()
                                                   
                                                   Text("Clear night sky is the optimal environment")
                                                       .font(.system(size: 20, weight: .black))
                                                   
                                               }
                                           }
                                           .background {
                                               RoundedRectangle(cornerRadius: 16)
                                                   .fill(.bar)
                                                   .opacity(0.01)
                                                   .frame(width: size.width, height: size.height)
                                                   .onTapGesture {
                                                       withAnimation(.linear(duration: 0.5)) {
                                                           tutorialfirst = false
                                                           
                                                       }
                                                       
                                                   }
                                           }
                                       }
                                       .opacity(tutorialfirst ? 1 : 0)
                                       
                                       
                                   
                               }
                               .padding()
                               
                           
                           
                           }
                           
                       }
                       
                   }
                    .opacity(observatory && startObservatoryExperience ? 1 : 0)

                }
            }
        }
        .ignoresSafeArea(edges: .all)
        
    }
}

struct MainView: UIViewRepresentable {
    @Binding var take: Bool
    @Binding var hubble: Bool
    @Binding var observatory: Bool
    @Binding var telescopeAR: Bool
    @Binding var hubbleMode: Bool
    @Binding var pullDevice: Bool
    
    func makeUIView(context: Context) ->ARView {
        
        let arView = ARView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), cameraMode: .nonAR, automaticallyConfigureSession: true)
        let fileURL = Bundle.main.url(forResource: "Hubble", withExtension: "reality")
        let scene = try! Entity.load(contentsOf: fileURL!)
        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: [0, 0, 0])
        cameraAnchor.name = "cameraAnchor"
        let telescope = try! ModelEntity.loadModel(named: "Hubble_Telescope")
        let telescopeAnchor = AnchorEntity(world: [0, 0, 0])
        telescopeAnchor.position = SIMD3<Float>(0.05, 0.05, 0.08)
        telescope.position = telescopeAnchor.position
        telescope.scale = SIMD3<Float>(0.00001, 0.00001, 0.0001)
        let anchor = AnchorEntity(world: [0, 0, 0])
        
        cameraAnchor.addChild(camera)
        cameraAnchor.look(at: SIMD3<Float>(x: 0, y: 0.7, z: 0), from: SIMD3<Float>(x: -0.15, y: 0, z: 0), relativeTo: nil)
        arView.scene.addAnchor(cameraAnchor)
        
        telescopeAnchor.addChild(telescope)
        arView.scene.addAnchor(telescopeAnchor)

        anchor.addChild(scene)
        arView.scene.anchors.append(anchor)
        
        return arView
    }
    
     func updateUIView(_ uiView: ARView, context: Context) {
        let camera = PerspectiveCamera()
         let anchor = AnchorEntity(world: [0, 0, 0])
        let telescope = try! ModelEntity.loadModel(named: "Hubble_Telescope")
        let telescopeAnchor = AnchorEntity()
        
         
         if take {
             uiView.snapshot(saveToHDR: true) { image in
                 let compressedImage = UIImage(data: (image?.pngData())!)
                   UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
                 
                 DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                     take = false
                 }
             }
             
         }
         
         if pullDevice {
             uiView.scene.anchors[0].position = SIMD3<Float>(0, 0.12, 0)
         }
         
         guard let cameraAnchor = uiView.scene.findEntity(named: "cameraAnchor") else { return }
         
         if hubbleMode {
             print(uiView.scene.anchors)
             let earth = uiView.scene.anchors[2].findEntity(named: "Earth")
             earth?.removeFromParent()
             uiView.scene.anchors.remove(at: 0)
             uiView.scene.anchors.remove(at: 0)
         }
         
        if hubble {
            telescopeAnchor.position = SIMD3<Float>(0.1, 0.05, 0.08)
            telescope.scale = SIMD3<Float>(1, 1, 1)
                    let orbitAnimation = OrbitAnimation(name: "orbit",
                                                        duration: 5,
                                                        axis: telescopeAnchor.position,
                                                        startTransform: Transform(scale: SIMD3<Float>(1,1,1),
                                                                                  rotation: simd_quatf(angle: 45, axis: SIMD3<Float>(0,0,0)),
                                                                                  translation: SIMD3<Float>(0,0.005,0.005)),
                                                        spinClockwise: false,
                                                        orientToPath: true,
                                                        rotationCount: 100,
                                                        bindTarget: .transform,
                                                        repeatMode: .repeat)
                    let animationResource = try! AnimationResource.generate(with: orbitAnimation)
                    camera.playAnimation(animationResource)
            
            cameraAnchor.look(at: telescopeAnchor.position, from: SIMD3<Float>(-0.13, 0.1, 0.09),relativeTo: telescopeAnchor)
            cameraAnchor.addChild(camera)
        } else {
            cameraAnchor.look(at: SIMD3<Float>(x: 0, y: 0.7, z: 0), from: SIMD3<Float>(x: -0.15, y: 0, z: 0), relativeTo: nil)
            camera.stopAllAnimations()
        }

        if telescopeAR {
            cameraAnchor.transform.translation = SIMD3<Float>(x: 0.06, y: 0.05, z: 0.08)
            uiView.cameraMode = .ar
            telescopeAR.toggle()
        }
        
    }
}


struct ObservatoryView: UIViewRepresentable {
    @Binding var ray1: Bool
    @Binding var observatoryAR: Bool
    @Binding var start: Bool
    @Binding var observatory: Bool
    @Binding var startObservatoryExperience: Bool
    @Binding var startExposure: Bool
    @State private var loading = false

    func makeUIView(context: Context) -> ARView {
        let observatoryArView = ARView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), cameraMode: .ar, automaticallyConfigureSession: false)
        observatoryArView.addCoaching()
        let anchor = AnchorEntity(world: [0,0,0])
        let fileURL = Bundle.main.url(forResource: "ObservatoryStarLink", withExtension: "reality")
        
        observatoryArView.automaticallyConfigureSession = false
        let configuration = ARWorldTrackingConfiguration()
        let supportLiDAR = ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh)
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.frameSemantics = .smoothedSceneDepth
        configuration.sceneReconstruction = .mesh
        observatoryArView.environment.sceneUnderstanding.options = .occlusion
        observatoryArView.session.run(configuration)
        
        let scene = try! Entity.load(contentsOf: fileURL!)
        anchor.addChild(scene)
        observatoryArView.scene.anchors.append(anchor)
       
        return observatoryArView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if startExposure {
            uiView.snapshot(saveToHDR: true) { image in
                let compressedImage = UIImage(data: (image?.pngData())!)

                  UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
            }
        }
    }
}


struct ObservatoryDescription: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: false)

        let fileURL = Bundle.main.url(forResource: "ObservatoryAndTrees", withExtension: "reality")
        let scene = try! Entity.load(contentsOf: fileURL!)
        let sceneAnchor = AnchorEntity(world: [0, 0, 0])
        let cameraEntity = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: [0, 0, 0])
        
        cameraAnchor.look(at: SIMD3<Float>(3, 3, 0), from: SIMD3<Float>(-0.6, 3, 5), relativeTo: sceneAnchor)
        cameraAnchor.addChild(cameraEntity)
        sceneAnchor.addChild(scene)
        arView.scene.anchors.append(sceneAnchor)
        arView.scene.anchors.append(cameraAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}


extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.goal = .anyPlane
        coachingOverlay.activatesAutomatically = true
        coachingOverlay.isHidden = true
        coachingOverlay.delegate = self
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(coachingOverlay)
    }

}



