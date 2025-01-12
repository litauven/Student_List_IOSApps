//
//  StudentListView.swift
//  StudentListApp
//
//  Created by Seteven on 11/01/25.
//

import SwiftUI

struct StudentListView: View {
    @State private var students: [Student] = []
    @State private var isLoading = false
    @State private var searchText = ""
    
    var filteredStudents: [Student] {
        if searchText.isEmpty {
            return students
        }
        return students.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(1.2)
                            .padding()
                    } else if students.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text("No students found")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(filteredStudents) { student in
                                    StudentCard(student: student)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 8)
                        }
                    }
                }
            }
            .navigationTitle("Students")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Search students")
            .onAppear {
                fetchStudents()
            }
        }
    }
    
    func fetchStudents() {
        isLoading = true
        APIService.fetchStudents { result in
            isLoading = false
            switch result {
            case .success(let fetchedStudents):
                withAnimation {
                    self.students = fetchedStudents
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

struct StudentCard: View {
    let student: Student
    @State private var imageLoaded = false
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: student.profilePicture)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 70, height: 70)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .onAppear { withAnimation { imageLoaded = true } }
                case .failure:
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(student.name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(student.address)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .opacity(imageLoaded ? 1 : 0.8)
        .animation(.easeInOut(duration: 0.2), value: imageLoaded)
    }
}

struct StudentListView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView()
    }
}
